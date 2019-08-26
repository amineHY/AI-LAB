FROM nvcr.io/nvidia/tensorrt:19.07-py3
LABEL maintainer "M. Amine Hadj-Youcef  <hadjyoucef.amine@gmail.com>"
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
	libtbb2 \
	libtbb-dev \
	libjpeg-dev \
	libgflags-dev \
	libgoogle-glog-dev \
	libprotobuf-dev \
	liblmdb-dev \
	libpng-dev \
	libtiff-dev \
	libavformat-dev \
	libpq-dev \
	libgtk2.0-dev \
	libhdf5-dev \
	libcurl4-openssl-dev\
	libprotoc-dev \
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

RUN pip3 install --upgrade pip


#---------------Install python dependencies---------
# RUN /opt/tensorrt/python/python_setup.sh


#---------------Install python requirements---------
COPY requirements.txt /tmp/
RUN pip3 install --requirement /tmp/requirements.txt
# find ./samples -name requirements.txt


#---------------Install opencv----------------------

WORKDIR /
ENV OPENCV_VERSION="4.1.0"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
 	&& unzip ${OPENCV_VERSION}.zip \
 	&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
 	&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
 	&& cmake -DBUILD_TIFF=ON \
 	-DBUILD_opencv_java=OFF \
 	-DWITH_CUDA=OFF \
 	-DWITH_OPENGL=ON \
 	-DWITH_OPENCL=ON \
 	-DWITH_IPP=ON \
 	-DWITH_TBB=ON \
 	-DWITH_EIGEN=ON \
 	-DWITH_V4L=ON \
 	-DBUILD_TESTS=OFF \
 	-DBUILD_PERF_TESTS=OFF \
 	-DCMAKE_BUILD_TYPE=RELEASE \
 	-DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
 	-DPYTHON_EXECUTABLE=$(which python3.6) \
 	-DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
 	-DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
 	.. \
	&& make install \
 	&& rm /${OPENCV_VERSION}.zip \
 	&& rm -r /opencv-${OPENCV_VERSION}
RUN  ln -s \
	/usr/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so \
	/usr/local/lib/python3.6/dist-packages/cv2.so


####################################################
# Deep learning frameworks
####################################################

#---------------Install PyTorch---------------------
RUN pip3 install torch==1.2.0+cu92 torchvision==0.4.0+cu92 -f https://download.pytorch.org/whl/torch_stable.html

#---------------Install TensorFlow------------------
RUN pip3 install tensorflow-gpu

#---------------Install ONNX------------------------
RUN pip3 install onnx onnxmltools onnxruntime-gpu

#---------------Install keras------------------------
RUN pip3 install keras

#---------------Install ONNX-TensorRT---------------

# RUN	git clone --recursive https://github.com/onnx/onnx-tensorrt.git &&\
# 	cd onnx-tensorrt &&\
# 	mkdir build  &&\
# 	cd build &&\
# 	cmake .. -DTENSORRT_ROOT=/usr/local/cuda-10.1/targets/x86_64-linux/include/ &&\
# 	make -j8 &&\
# 	make install &&\
# 	ldconfig && \
# 	cd .. && \
# 	python setup.py build &&\
# 	python setup.py install &&\
# 	rm -rf ./build/


#----------------Perform some cleaning-----------------------
RUN (apt-get -qq autoremove -y; \
	apt-get -qq autoclean -y)


#----------------set the working directory-------------------
WORKDIR /workspace


CMD ["jupyter", "notebook", "--allow-root", "--port=8888", "--ip=0.0.0.0", "--no-browser"]
