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
First, you must have `docker-ce` installed on your machine to be able to use the pre-configured development environment.
To do that, simply follow the steps to install [docker for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/), or select the suitable version depending on your OS.

Run the AI-lab docker image by typing in the terminal:

``` bash
	xhost +

	docker run -it --rm -v $(pwd):/workspace \
	 --runtime=nvidia -w /workspace \
	 -v /tmp/.X11-unix:/tmp/.X11-unix \
	 -e DISPLAY=$DISPLAY \
	 -p 8888:8888 aminehy/ai-lab:latest
```

## Launch Jupyter notebook

	jupyter notebook --allow-root --port=8888 --ip=0.0.0.0 --no-browser
