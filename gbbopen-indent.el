;;;; -*- Mode:Emacs-Lisp -*-
;;;; *-* File: /usr/local/gbbopen/gbbopen-indent.el *-*
;;;; *-* Edited-By: cork *-*
;;;; *-* Last-Edit: Tue May 27 10:33:50 2008 *-*
;;;; *-* Machine: cyclone.cs.umass.edu *-*

;;;; **************************************************************************
;;;; **************************************************************************
;;;; *
;;;; *                       GBBopen ELI Indentations 
;;;; *
;;;; **************************************************************************
;;;; **************************************************************************
;;;
;;; Written by: Dan Corkill
;;;
;;; Copyright (C) 2002-2008, Dan Corkill <corkill@GBBopen.org>
;;; Part of the GBBopen Project (see LICENSE for license information).
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;;;
;;;  07-18-02 File created.  (Corkill)
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

(defun set-indent-hook (symbol value)
  (put symbol 'lisp-indent-function value)
  (put symbol 'fi:lisp-indent-hook value))

(defun gbbopen:add-indentation ()
  (interactive)
  ;; "Improve" some CL indentations:
  (set-indent-hook 'if 3)
  (set-indent-hook 'setf  0)
  ;; GBBopen entity indentations:
  (set-indent-hook 'define-module 1)
  (set-indent-hook 'destructure-extent 2)
  (set-indent-hook 'make-space-instance 2))

(add-hook 'lisp-mode-hook (function gbbopen:add-indentation))
(add-hook 'fi:lisp-mode-hook (function gbbopen:add-indentation))

;;; ***************************************************************************
;;; *                              End of File                                *
;;; ***************************************************************************

