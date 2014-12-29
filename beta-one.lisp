(ql:quickload '("wookie" "cl-who" "cl-redis"))

(defpackage :beta-one
  (:use :cl :wookie :who :redis))

(in-package :beta-one)

(load "clojure.lisp")

(load-plugins)

(defun homepage ()
  "The homepage"
  (let ((lim 200))
    (with-html-output-to-string (s)
      (:html
       (:head
	(:title "Hello world"))
       (:body
	(:header)
	(:center
	 (let ((nama "John Paul isPrime"))
	   (htm (:h1 (str (cstr "Hellow world from restas " nama))
		     (:br)
		     (:h3
		      (str (cstr "As you can see, this is a test page "
				 "for daemonized sbcl, restas, cl-who, and redis"))))))
	 (:ul
	  (mapcar
	   #'(lambda (x)
	       (let* ((res (read-from-string (red:get (cstr "prime" x))))
		      (numstat (getf res 'statprime))
		      (num (cstr "The number "
				 (getf res 'number)
				 " prime status "
				 numstat)))
		 (htm (:li (str num)))))
	   (loop for i from 2 to lim collect i))))
	(:footer))))))

(defroute (:get "/") (req res)
  (send-response res :body (homepage)))

(defun run (port)
  (progn (connect)
	 (as:with-event-loop ()
	   (start-server (make-instance 'listener :port port)))
	 (cstr "Wookie listening on port " port)))

(run 3000)

