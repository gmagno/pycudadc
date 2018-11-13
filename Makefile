.PHONY: clean install build run run-bash

install:
	pipenv install --dev

build:
	docker build -t godwitlabs/pycudadc .

run:
	xhost +si:localuser:root\
	&& docker run --device=/dev/input/ --runtime=nvidia -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix godwitlabs/pycudadc\
	&& xhost -si:localuser:root

run-bash:
	xhost +si:localuser:root\
	&& docker run --device=/dev/input/ --runtime=nvidia -ti --rm -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix godwitlabs/pycudadc bash\
	&& xhost -si:localuser:root

clean:
	find . \( -name __pycache__ -o -name "*.pyc" -o -name .pytest_cache \) -exec rm -rf {} +
