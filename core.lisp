(ql:quickload '("wookie" "cl-who" "cl-redis"))

(restas:define-module #:core-alfa
    (:use :cl :restas :who :redis))

(in-package :core-alfa)

