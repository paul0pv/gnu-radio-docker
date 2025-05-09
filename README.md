# 📻 Radioconda + GNU Radio GUI (in Docker/Podman)

Welcome to the *Dockerized Radioconda Experience™* — now with GUI support, because clicking stuff is half the fun of SDR.

This container gives you:

✅ [Radioconda](https://github.com/ryanvolz/radioconda)  
✅ [GNU Radio](https://www.gnuradio.org/) with GUI (like `gnuradio-companion`)  
✅ GUI working under **Wayland** (Hyprland tested!) via **XWayland**

> ⚠️ This setup was built on a *real Linux environment with XWayland*, not WSL, not on Mars, not in Windows 95. If you're using WSL — bless your soul — things **might break** unless you've manually rigged a working X server. You're on your own there, explorer.

---

## 🚀 Quick Start

Make sure you're running a Wayland-compatible setup **with XWayland support**, like Hyprland (tested), and that `xhost` is installed.

### 1. Allow X11 access (on the host):

```bash
xhost +SI:localuser:$(whoami)
```

### 2. Clone & build:

```bash
git clone https://github.com/your-username/radioconda-gui-container.git
cd radioconda-gui-container
podman-compose up --build -d  # or docker-compose if you're using Docker
```

### 3. Exec into the container

```bash
podman exec -it radioconda_app bash
```
### 4. Run the GUI (from inside):

```bash
export DISPLAY=$DISPLAY
export QT_QPA_PLATFORM=xcb
gnuradio-companion
```

If a window pops up, you win.

## 🛠️ Files in this repo

| File                 | Purpose                                      |
| -------------------- | -------------------------------------------- |
| `Dockerfile`         | Builds the Radioconda + GNU Radio container  |
| `docker-compose.yml` | Runs the container and mounts the X socket   |
| `gnuradio.sh`        | Optional launcher script (copy GUI settings) |
| `data/`              | Persistent app data volume (bind mounted)    |


## 🤯 Common Gotchas

❌ "Could not connect to display"

- Did you run xhost +SI:localuser:$(whoami) on the host?

- Is DISPLAY variable set correctly inside the container?

- Did you mount /tmp/.X11-unix in the volume section?

❌ GUI freezes or crashes

Set QT_QPA_PLATFORM=xcb to force Qt to use X11, not Wayland.

Don’t forget DISPLAY=$DISPLAY.

❌ You're using WSL

GUI apps might work if you install VcXsrv or X410, set DISPLAY=host.docker.internal:0, and say a prayer.

This setup isn’t built/tested for WSL. It probably needs some love.

## 🧪 Tested On

✅ Arch Linux + Hyprland

✅ Podman + Podman Compose

✅ XWayland installed & working

❌ WSL2 (Good luck. No promises.)

## 🧬 Make it Yours

This is a one-size-fits-one solution. If your needs differ:

- Replace the Radioconda version in Dockerfile (RELEASE_VERSION)

- Add more conda packages via mamba install ...

- Modify volumes and entrypoints as you see fit

- Pull requests, forks, and debugging tales welcome.


## 🧼 Cleanup

To stop and remove everything:

```bash
podman-compose down
xhost -SI:localuser:$(whoami)
```

## 🛎️ License

MIT. Go wild.

🎙️ Made with way too much coffee and a burning desire to make SDR easier (actually it’s because of my TIC with not having more and more packages in the system, lol).
