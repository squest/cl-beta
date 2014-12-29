(defmacro def (vname vbody)
  `(defparameter ,vname ,vbody))

(defmacro fn (body)
  `(lambda (%) ,body))

(defmacro fn2 (body)
  `(lambda (%1 %2) ,body))

(defmacro fn3 (body)
  `(lambda (%1 %2 %3) ,body))

(defmacro ->> (&body body)
  (reduce (fn2 (append %2 (list %1))) body))

(defmacro -> (&body body)
  (reduce (fn2 (append (list (first %2))
		       (list %1)
		       (rest %2)))
	  body))

(defun cstr (&rest args)
  (apply 'concatenate 'string
	 (mapcar #'(lambda (x) (if (stringp x) x
			      (write-to-string x)))
		 args)))
