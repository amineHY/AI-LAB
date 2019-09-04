# AI-lab: The Ideal Development Environment for Data Scientists to Develop and Export Machine Learning Models


![All in one solution for data science](AI-lab_logos.png)


<!-- TOC -->

- [AI-lab: The Ideal Development Environment for Data Scientists to Develop and Export Machine Learning Models](#ai-lab-the-ideal-development-environment-for-data-scientists-to-develop-and-export-machine-learning-models)
	- [Description](#description)
	- [USAGE](#usage)
	- [Launch an IDE and Start Developing](#launch-an-ide-and-start-developing)
		- [1. Jupyter notebook](#1-jupyter-notebook)
		- [2. VS Code](#2-vs-code)
	- [Do you have any suggestions?](#do-you-have-any-suggestions)

<!-- /TOC -->

## Description
This project is reserved for creating a new development environment using docker for developing AI models in data science, in particular, computer vision.

I hand-crafted AI-lab to take advantage of docker capability and to have a reproducible and portable development environment. AI-lab allows you developing your artificial intelligence based computer vision application in Python using the most used artificial intelligence frameworks.

AI-lab is meant to be used to building, training, validating, testing your deep learning models, for instance is a a good tool to do transfer learning. It includes:

	- Ubuntu 18.04
	- NVIDIA CUDA 10.1
	- NVIDIA cuDNN 7.6.0
	- OpenCV 4.1.0
	- Python 3.6
	- Most used AI framework:
    	- TensorRT
      	- TensorFlow
      	- PyTorch
      	- ONNX
      	- Keras
      	- ONNX-TensorRT
    	- Jupyter-lab
    	- VS Code integration with remote development
    	- numpy
    	- matplotlib
    	- scikit-learn
    	- scipy
    	- pandas
    	- and more

## USAGE

To install AI-lab you must have `docker-ce` installed on your machine to be able to use the pre-configured development environment. To do that, simply follow the steps to install [docker for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/), or select the suitable version depending on your OS.


* Pull AI-lab from Docker Hub

	```bash
		docker pull aminehy/ai-lab
	```

* Run the AI-lab and start your development

	* Move to your application folder
	``` bash
		cd path/to/folder/application
	```

	* then run AI-lab
	``` bash
		xhost +

		docker run -it --rm -v $(pwd):/workspace \
		--runtime=nvidia -w /workspace \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=$DISPLAY \
		-p 8888:8888 -p 6006:6006 aminehy/ai-lab:latest
	```

## Launch an IDE and Start Developing
### 1. Jupyter notebook

If AI-lab runs correctly on your machine then `Jupyter notebook` should run automatically. If this is not the case, launch it from the terminal with this command

```bash
jupyter notebook --allow-root --port=8888 --ip=0.0.0.0 --no-browser
```

### 2. VS Code

[VS Code](https://code.visualstudio.com/) offers the possibility to develop from inside of AI-lab through the extension [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack). Read more in details [here](https://code.visualstudio.com/docs/remote/containers).


First clone this repository and move to it
```bash
	git clone https://github.com/amineHY/AI-lab.git /path/to/folder/application
	cd /path/to/folder/application
```

move to that directory then start developing by launching VS Code
copy the content of the folder `vscode_remote_dev` into your workspace
``` bash
	sudo cp -R /path/to/folder/application/vscode_remote_dev/ .
	code .
```

## Do you have any suggestions?

Please contact me and let me know [LinkedIn](https://www.linkedin.com/in/aminehy/).
