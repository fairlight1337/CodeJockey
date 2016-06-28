CodeJockey
===

This Emacs package contains functions for automating routine tasks when coding. Right now, it is highly specialized on C++ coding, but will be made more broad in the future.

In its first, bare version, it supports the auto-generation of C++ class code, specifically the declaration and implementation:


  * Declaration of a class: `M-x cj-make-class-declaration`, arguments: `class-name`, `[namespace]`

  * Implementation of a class: `M-x cj-make-class-implementation`, arguments: `class-name`, `[namespace]`
