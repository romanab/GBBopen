;;;; -*- Mode:Common-Lisp; Package:CL-USER; Syntax:common-lisp -*-
;;;; *-* File: /usr/local/gbbopen/source/gbbopen/test/journal-writer.lisp *-*
;;;; *-* Edited-By: cork *-*
;;;; *-* Last-Edit: Sat Feb 19 17:23:46 2011 *-*
;;;; *-* Machine: twister.local *-*

;;;; **************************************************************************
;;;; **************************************************************************
;;;; *
;;;; *                        Journal Writer Example
;;;; *
;;;; **************************************************************************
;;;; **************************************************************************
;;;
;;; Written by: Dan Corkill
;;;
;;; Copyright (C) 2011, Dan Corkill <corkill@GBBopen.org>
;;; Part of the GBBopen Project.
;;; Licensed under Apache License 2.0 (see LICENSE for license information).
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;;;
;;;  02-16-11 File created.  (Corkill)
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

(in-package :cl-user)

;; Compile/load GBBopen's :streaming module:
(streaming :create-dirs)

;; Compile/load the :tutorial module (without running it):
(cl-user::tutorial-example :create-dirs :noautorun)

;; Create the journal streamer:
(defparameter *streamer*
    (make-journal-streamer "~/tutorial.jnl" :package ':tutorial))

(add-mirroring *streamer* 'standard-space-instance)
(add-mirroring *streamer* 'path)
(add-mirroring *streamer* 'location)

;; Generate some data, writing everything as a single queued block:
(with-queued-streaming (*streamer* ':tutorial)
  (take-a-walk))

;; Delete an instance, also using WITH-QUEUED-STREAMING:
(with-queued-streaming (*streamer* ':with-queued)
  (delete-instance (find-instance-by-name 10 'location)))

;; Change a nonlink-slot value:
(setf (time-of (find-instance-by-name 11 'location)) 9)

;; Perform an unlink:
(unlinkf (previous-location-of (find-instance-by-name 9 'location))
         (find-instance-by-name 8 'location))

;; Perform a link:
(linkf (next-location-of (find-instance-by-name 8 'location))
       (find-instance-by-name 9 'location))

;; Journal a silly command:
(stream-command-form '(:print "All done!") *streamer*)

;;; ===========================================================================
;;;				  End of File
;;; ===========================================================================









