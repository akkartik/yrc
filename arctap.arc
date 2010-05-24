;;; http://testanything.org
;;; Original: Shlomi Fish

(= test-failures* 0)
(def ok (value (o msg))
     (if value (pr "ok") (pr "not ok"))
     (pr " ")
     (if msg (pr "- " msg))
     (prn)
     (unless value ++.test-failures*)
     value)

(mac def-test-fn(fn-name)
  `(def ,(symize "test-" fn-name) (msg expected got)
     (let verdict (ok (,fn-name expected got) msg)
       (if verdict
         t
         (do
           (ero "expected" expected)
           (ero "got" got)
           nil)))))

(def-test-fn is)
(def-test-fn iso)
(def-test-fn smatch)

(def test-ok(msg got)
  (ok got msg))
(def test-nil(msg got)
  (ok not.got msg))

(= is-deeply test-iso)
