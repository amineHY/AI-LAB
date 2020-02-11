
FROM nvcr.io/nvidia/tensorrt:19.10-py3

LABEL maintainer "M. Amine Hadj-Youcef  <hadjyoucef.amine@gmail.com>"

# If you have any comment : LinkedIn - https://www.linkedin.com/in/aminehy/

ARG DEBIAN_FRONTEND=noninteractive


ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

##---------------install prerequisites---------------

RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
	protobuf-compiler \
	geany \
	python3 \
	python3-tk \
	python3-pip \
	python3-dev \
	python3-setuptools \
	eog \
	gedit \
	build-essential \
	ssh \
	ca-certificates \
	curl \
	cmake \
	git \
	wget \
	unzip \
	yasm \
	pkg-config \
	libswscale-dev \
	libv4l-dev\
	libxvidcore-dev\
	libx264-dev\
	libtbb2 \
	libtbb-dev \
	libjpeg-dev \
	libgflags-dev \
	libgoogle-glog-dev \
	libprotobuf-dev \
	liblmdb-dev \
	libpng-dev \
	libtiff-dev \
	libavcodec-dev \
	libavformat-dev \
	libpq-dev \
	libgtk2.0-dev \
	libgtk-3-dev\
	libhdf5-dev \
	libatlas-base-dev \
	gfortran\
	libcurl4-openssl-dev\
	libprotoc-dev \
	swig\
	qt5-default \
	libboost-all-dev \
	libboost-dev \
	xdg-utils \
	snapd \
	rsync \
	&& rm -rf /var/lib/apt/lists/*

RUN cd /usr/local/bin &&\
	ln -s /usr/bin/python3 python


#---------------Install pip package---------------
RUN cd /usr/local/src \
	&& wget -q  https://bootstrap.pypa.io/get-pip.py \
	&& python3 get-pip.py \
	&& pip3 install --upgrade pip \
	&& rm -f get-pip.py \
	&& python3 -m pip --version\
	&& pip install --user --upgrade pip

#---------------Install opencv----------------------
WORKDIR /
ENV OPENCV_VERSION="4.2.0"
RUN wget -O opencv.zip  https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
RUN wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip
RUN unzip opencv.zip
RUN unzip opencv_contrib.zip
RUN mv opencv-4.2.0 opencv
RUN mv opencv_contrib-4.2.0 opencv_contrib
RUN mkdir /opencv/cmake_binary
WORKDIR /opencv/cmake_binary

# Configure OpenCV with NVIDIA GPU support
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE\
	-D CMAKE_INSTALL_PREFIX=/usr/local\
	-D INSTALL_PYTHON_EXAMPLES=ON\
	-D INSTALL_C_EXAMPLES=OFF\
	-D OPENCV_ENABLE_NONFREE=ON\
	-D WITH_CUDA=ON\
	-D WITH_CUDNN=ON\
	-D OPENCV_DNN_CUDA=ON\
	-D ENABLE_FAST_MATH=1\
	-D CUDA_FAST_MATH=1\
	-D CUDA_ARCH_BIN=3.5,5.3,6.0,6.1,7.0,7.5\
	-D WITH_CUBLAS=1\
	-D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules\
	-D HAVE_opencv_python3=ON\
	-D PYTHON_EXECUTABLE=$(which python3.6) \
	-D BUILD_EXAMPLES=ON \
	-D BUILD_TESTS=OFF \
	-D BUILD_PERF_TESTS=OFF ..

#   -D BUILD_TIFF=ON \
# 	-D BUILD_opencv_java=OFF \
# 	-D WITH_CUDA=ON \
# 	-D WITH_CUDNN=ON \
# 	-D OPENCV_DNN_CUDA=ON\
# 	-D ENABLE_FAST_MATH=1 \
# 	-D CUDA_FAST_MATH=1 \
# 	-D CUDA_ARCH_BIN=3.5\
# 	-D WITH_CUBLAS=1 \
# 	-D ENABLE_AVX=ON \
# 	-D WITH_OPENGL=ON \
# 	-D WITH_OPENCL=ON \
# 	-D WITH_IPP=ON \
# 	-D WITH_TBB=ON \
# 	-D WITH_EIGEN=ON \
# 	-D WITH_V4L=ON \
# 	-D BUILD_TESTS=OFF \
# 	-D BUILD_PERF_TESTS=OFF \
# 	-D HAVE_opencv_python3=ON\
# 	-D CMAKE_BUILD_TYPE=RELEASE \
# 	-D CMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
# 	-D PYTHON_EXECUTABLE=$(which python3.6) \
# 	-D PYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
# 	-D PYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
# 	-D INSTALL_PYTHON_EXAMPLES=ON \
# 	-D INSTALL_C_EXAMPLES=OFF \
# 	-D OPENCV_ENABLE_NONFREE=ON \
# 	-D OPENCV_GENERATE_PKGCONFIG=ON \
# 	-D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
# 	-D BUILD_EXAMPLES=ON \
# 	-D CUDA_TOOLKIT_ROOT_DIR= /usr/local/cuda-10.1 \
# 	-DWITH_QT=ON ..

# RUN chmod +x download_with_curl.sh \
#  	&& sh ./download_with_curl.sh

# Compile OpenCV with “dnn” GPU support
RUN make -j8 \
	&& make install \
	&& rm /opencv.zip \
	&& rm /opencv_contrib.zip \
	&& rm -rf /opencv \
	&& rm -rf /opencv_contrib

RUN  ln -s \
	/usr/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so \
	/usr/local/lib/python3.6/dist-packages/cv2.so


####################################################
# Deep learning frameworks
####################################################

# #---------------Install PyTorch---------------------
# RUN pip3 install torch==1.2.0+cu92 torchvision==0.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html

# #---------------Install TensorFlow------------------
# RUN pip3 install tensorflow-gpu
# RUN pip3 install tflearn

# #---------------Install ONNX------------------------
# RUN pip3 install onnx onnxmltools onnxruntime-gpu

# #---------------Install keras------------------------
# RUN pip3 install keras

# #---------------Install ONNX-TensorRT---------------
# # determine DGPU_ARCHS from https://developer.nvidia.com/cuda-gpus
# # https://github.com/onnx/onnx-tensorrt

# RUN	git clone --recursive -b 6.0 https://github.com/onnx/onnx-tensorrt.git &&\
# 	cd onnx-tensorrt &&\
# 	mkdir build  &&\
# 	cd build &&\
# 	cmake .. -DCUDA_INCLUDE_DIRS=/usr/local/cuda/include -DTENSORRT_ROOT=/usr/src/tensorrt -DGPU_ARCHS="35" &&\
# 	make -j8 &&\
# 	make install &&\
# 	ldconfig && \
# 	cd .. && \
# 	python setup.py build &&\
# 	python setup.py install &&\
# 	rm -rf ./build/

# #----------------Install TensorBoardX -----------------------
# RUN git clone https://github.com/lanpa/tensorboardX && cd tensorboardX && python setup.py install

# #---------------Install python requirements---------
# COPY requirements.txt /tmp/
# RUN pip3 install --requirement /tmp/requirements.txt

# # ---------------Install Heroku for deplyment of application on the server
# RUN curl https://cli-assets.heroku.com/install.sh | sh

# # ---------------Configure Streamlit
# RUN mkdir -p /root/.streamlit

# RUN bash -c 'echo -e "\
# 	[general]\n\
# 	email = \"hadjyoucef.amine@gmail.com\"\n\
# 	" > /root/.streamlit/credentials.toml'

# RUN bash -c 'echo -e "\
# 	[server]\n\
# 	enableCORS = false\n\
# 	" > /root/.streamlit/config.toml'

# EXPOSE 8501

# # Declare environnement variable
# RUN echo 'export LC_ALL=C.UTF-8' >> ~/.bashrc
# RUN echo 'export LANG=C.UTF-8' >> ~/.bashrc


# #----------------Perform some cleaning-----------------------
# RUN (apt-get -qq autoremove -y; \
# 	apt-get -qq autoclean -y)

# #----------------set the working directory-------------------
# WORKDIR /workspace

# CMD ["jupyter", "notebook", "--allow-root", "--port=8888", "--ip=0.0.0.0", "--no-browser"]
