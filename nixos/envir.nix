{ config, pkgs, lib, ... }:
{

  environment.loginShellInit = ''
    
   export EGL_PLATFORM=wayland

   export _JAVA_AWT_WM_NONREPARENTING=1
   export XCURSOR_SIZE=24

   export LIBVA_DRIVER_NAME=nvidia
   export XDG_SESSION_TYPE=wayland
   export GMB_BACKEND=nvidia-drm
   export __GLX_VENDOR_LIBRARY_NAME=nvidia
   export WLR_NO_HARDWARE_CURSORS=1
 
   export GDK_BACKEND=wayland

#   export MOZ_DISABLE_RDD_SANDBOX=1
#   export MOZ_ENABLE_WAYLAND=1

   export NVD_BACKEND=egl
  '';

  }
