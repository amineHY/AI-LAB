# AI-lab: A development environment for AI-based computer vision application

## The container includes

	- Ubuntu 18.04
	- NVIDIA CUDA 10.1
	- NVIDIA cuDNN 7.6.0
	- OpenCV 3.4.6
	- Python 3.6
	- jupyter-lab
	- Most used AI framework: TensorRT, TensorFlow, PyTorch, ONNX, Keras and more.


## Run docker image

Enter the following command in the terminal:

	xhost +

	docker run -it --rm -v $(pwd):/workspace \
	 --runtime=nvidia -w /workspace \
	 -v /tmp/.X11-unix:/tmp/.X11-unix \
	 -e DISPLAY=$DISPLAY \
	 -p 8888:8888 aminehy/AI-lab:v1


## Launch Jupyter notebook

	jupyter notebook --allow-root --port=8888 --ip=0.0.0.0 --no-browser
