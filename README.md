# Nvim L-ed 
Neovim Lizard Edition, By Reptiles For Reptiles
Comes with it's own theme **based theme**

## Install  
Global dependencies for **Arch** or **Gentoo**: 
Note that these dependecy requirements are pretty easy to fulfill on any distro, this is just what I use. 

Most issues will arise from the texlive package and I suggest you pull the most complete version of it on debian, nixOS, centOS.. etc. Pull the whole group if thats how your package manager of choice works...   

**Arch:**  
```sh
sudo pacman -S neovim \
               nodejs \
               npm \
               unzip \
               ripgrep \
               fd \
               texlive \
               mupdf \
               git \
               github-cli
```


**Gentoo:**
```sh
echo "app-text/texlive extra science xetex luatex metapost tex4ht texi2html truetype xml png" | sudo tee -a /etc/portage/package.use/texlive

sudo emerge -av app-editors/neovim \
               net-libs/nodejs \
               app-arch/unzip \
               sys-apps/ripgrep \
               sys-apps/fd \
               app-text/texlive \
               app-text/mupdf \
               dev-vcs/git \
               dev-util/github-cli
 

```

Once you have the global deps run this

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Jason-Goon/Nvim-L-ed/master/setup.sh)"
```

To delete the configuration for uninstall or before install if any nvim dotfiles exist 

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Jason-Goon/neovimugicha/master/cleanup.sh)"
```


## Features

- **Lazy.nvim** for plugin management  
- **Nvim-Tree** file browser – `<Space>e` to toggle  
- **Treesitter** syntax highlighting  
- **LSP support** – Rust, C, C++, Python, TypeScript, HTML, CSS  
- **Git/ copilot integration**  
- **Based Theme**  
- **LaTeX support with vimtex** – Live preview via Zathura  
- **GitHub Copilot integration** – `<Space>co` to toggle  
- **ASCII art start screen**  
- **Quick project setup for Math, Notes, and Assignments**  
- **Standalone configuration files pulled from GitHub**  


## Keybinds

- `<Space>e` → Toggle file tree (Nvim-Tree)  
- `<Space>q` → Close buffer  
- `<Space>w` → Save file  
- `<Space>co` → Toggle GitHub Copilot  
- `:NewMathProject <name>` → Create a new Math project  
- `:NewNotes <name>` → Create a new Notes project  
- `:NewAssignment <name>` → Create a new Assignment project  


## Notes  

- **To reset or uninstall**, run `cleanup.sh`.  
- **If a plugin doesn’t load**, run `:Lazy sync` inside Neovim.  
- **LSPs should install automatically** via Mason. If missing, verify dependencies.  
- **System dependencies must be installed manually** before running Neovim.  
- **My student number is 150382131** For any professors I linked this to. I'm a pretty private person 

