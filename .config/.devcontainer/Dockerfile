FROM archlinux

RUN pacman -Syu haskell-language-server sudo eza zsh python xmonad xmonad-contrib ansible-lint --noconfirm

RUN useradd user -m -G wheel && \
	echo '%wheel ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers && \
	usermod -s /bin/zsh user

USER user

RUN mkdir -p ~/.config ~/.local/share/
