;;;; -*- Mode:Common-Lisp; Package:GBBOPEN; Syntax:common-lisp -*-
;;;; *-* File: /usr/local/gbbopen/source/gbbopen/system-events.lisp *-*
;;;; *-* Edited-By: cork *-*
;;;; *-* Last-Edit: Wed Mar  3 04:33:16 2010 *-*
;;;; *-* Machine: cyclone.cs.umass.edu *-*

;;;; **************************************************************************
;;;; **************************************************************************
;;;; *
;;;; *                          System Event Classes
;;;; *
;;;; **************************************************************************
;;;; **************************************************************************
;;;
;;; Written by: Dan Corkill
;;;
;;; Copyright (C) 2004-2010, Dan Corkill <corkill@GBBopen.org>
;;; Part of the GBBopen Project (see LICENSE for license information).
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
;;;
;;;  03-16-04 File created.  (Corkill)
;;;  03-19-04 Moved standard-event-instance to events.lisp.  (Corkill)
;;;  07-05-04 Remove link/nonlink-slot initialization events.  (Corkill)
;;;  07-20-04 Add :metaclass specifiers to all system event-class definitions
;;;           to eliminate the need for load-time class changes.  (Corkill)
;;;  08-22-05 Add print-instance-slots support for event instances.  (Corkill)
;;;  09-06-06 Add instance change-class events.  (Corkill)
;;;
;;; * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

(in-package :gbbopen)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(slot-of)))

 ;;; ---------------------------------------------------------------------------
  
(define-event-class non-instance-event ()
  ()
  (:abstract t)
  (:metaclass non-instance-event-class)
  (:event-printing t :permanent nil)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class instance-event ()
  ()
  (:abstract t)
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class single-instance-event (instance-event)
  ((instance))
  (:abstract t)
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

(defmethod print-instance-slots ((instance single-instance-event) stream)
  (call-next-method)
  (print-instance-slot-value instance 'instance stream :function 'type-of))

;;; ---------------------------------------------------------------------------

(define-event-class multiple-instance-event (instance-event)
  ((instances))
  (:abstract t)
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

(defmethod print-instance-slots ((instance multiple-instance-event) stream)
  (call-next-method)
  (flet ((fn (instances)
           (mapcar #'type-of instances)))
    (declare (dynamic-extent #'fn))
    (print-instance-slot-value instance 'instances stream :function #'fn)))

;;; ---------------------------------------------------------------------------

(define-event-class create/delete-instance-event (single-instance-event)
  ()
  (:abstract t)
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class create-instance-event (create/delete-instance-event)
  ()
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class delete-instance-event (create/delete-instance-event)
  ()
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class instance-deleted-event (create/delete-instance-event)
  ()
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class change-instance-class-event (create/delete-instance-event)
  ((new-class))
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class instance-changed-class-event (create/delete-instance-event)
  ((previous-class))
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class space-instance-event (single-instance-event)
  ((space-instance))
  (:abstract t)
  (:metaclass space-instance-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

(defmethod print-instance-slots ((instance space-instance-event) stream)
  (call-next-method)
  (print-instance-slot-value 
   instance 'space-instance stream :function 'instance-name-of))

;;; ---------------------------------------------------------------------------

(define-event-class add-instance-to-space-instance-event (space-instance-event)
  ()
  (:metaclass space-instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class move-instance-within-space-instance-event
    (space-instance-event)
  ()
  (:metaclass space-instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class remove-instance-from-space-instance-event 
    (space-instance-event)
  ()
  (:metaclass space-instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class link/nonlink-slot-event (single-instance-event)
  ((slot))
  (:abstract t)
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

(defmethod print-instance-slots ((instance link/nonlink-slot-event) stream)
  (call-next-method)
  (print-instance-slot-value 
   instance 'slot stream :function 'slot-definition-name))

;;; ---------------------------------------------------------------------------

(define-event-class link/nonlink-slot-modify-event (link/nonlink-slot-event)
  ((current-value)
   (initialization))
  (:abstract t)
  (:metaclass instance-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class update-nonlink-slot-event (link/nonlink-slot-modify-event)
  ()
  (:metaclass nonlink-slot-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class link-slot-event (link/nonlink-slot-event)
  ((directp))
  (:abstract t)
  (:metaclass link-slot-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class link-event (link-slot-event link/nonlink-slot-modify-event)
  ((added-instances))
  (:metaclass link-slot-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

;;; ---------------------------------------------------------------------------

(define-event-class unlink-event
    (link-slot-event link/nonlink-slot-modify-event)
  ((removed-instances))
  (:metaclass link-slot-event-class)
  (:export-class-name t)
  (:export-accessors t)
  (:system-event t))

;;; ---------------------------------------------------------------------------
;;;   Timer Events

(define-event-class timer-interrupt-event (non-instance-event)
  ()
  (:metaclass non-instance-event-class)
  (:export-class-name t)
  (:system-event t))

;;; ===========================================================================
;;;				  End of File
;;; ===========================================================================
