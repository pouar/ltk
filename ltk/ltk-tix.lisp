;;; tix specific extension to ltk

(defpackage "LTK-TIX"
  (:use "COMMON-LISP"
	"LTK"
	)
  (:export
   	"BALLOON"
	"BALLOON-BIND"
	"BALLOON-UNBIND"	
   ))

(in-package ltk-tix)

(eval-when (:load-toplevel)
  (setf *init-wish-hook* (append *init-wish-hook*
				 (lambda ()
				   (send-wish "package require Tix"))
				 )))

(defclass balloon (widget)
  ())

;; important config options:
;; statusbar: statusbar to display the text on
;; initwait: time in ms until the help appears


(defmethod initialize-instance :after ((b balloon) &key)
  (format-wish "tixBalloon ~a" (path b)))

(defgeneric balloon-bind (b w &key msg balloonmsg statusmsg))
(defmethod balloon-bind ((balloon balloon) (widget widget) &key msg balloonmsg statusmsg)
  (format-wish "~a bind ~a~@[ -msg {~a}~]~@[ -balloonmsg {~a}~]~@[ -statusmsg {~a}~]" (path balloon) (path widget) msg balloonmsg statusmsg))

(defgeneric balloon-unbind (b w))
(defmethod balloon-unbind ((balloon balloon) (widget widget))
  (format-wish "~a unbind ~a" (path balloon) (path widget)))

