(require mzscheme)

(define (yinit filename)
  (let ((c (char->integer (string-ref filename 0))))
    (if (and (>= c (char->integer #\0))
             (<= c (char->integer #\9)))
      (let* ((len (string-length filename))
             (ext (substring filename (- len 4))))
        (cond ((equal? ext ".yrc")  (yload filename)) ; yload not defined yet
              ((equal? ext ".scm")  (load filename)))))))

(map (lambda(x) (yinit (path->string x)))
     (directory-list "."))

(yrepl)
