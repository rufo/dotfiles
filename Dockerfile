# From https://github.com/neovim/neovim/issues/15143#issuecomment-2326468274
FROM glcr.b-data.ch/neovim/nvsi:latest AS nvsi
FROM ubuntu

RUN apt-get update \
	&& apt-get install -y \
	curl \
	git \
	python3 \
	sudo \
	vim \
	wget \
	zsh \
  build-essential

COPY --from=nvsi /usr/local /usr/local

ARG USER=rufo
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
	&& echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
	&& chmod 0440 /etc/sudoers.d/${USER}
USER ${USER}
WORKDIR /home/${USER}
RUN sudo mkdir -p /home/${USER}/.local/share \
  && sudo chown -R ${USER}:${USER} /home/${USER}/.local

ARG CHEZMOI_VERSION=2.52.2
ARG CHEZMOI_ARCH
RUN curl -LO https://github.com/twpayne/chezmoi/releases/download/v${CHEZMOI_VERSION}/chezmoi_${CHEZMOI_VERSION}_linux_${CHEZMOI_ARCH}.deb \
  && sudo dpkg -i chezmoi_${CHEZMOI_VERSION}_linux_${CHEZMOI_ARCH}.deb \
  && rm chezmoi_${CHEZMOI_VERSION}_linux_${CHEZMOI_ARCH}.deb
