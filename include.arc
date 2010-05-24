(= lib-path* (list "." arc-dir* (string arc-dir* "/lib")))

(def include(f)
  (each dir lib-path*
        (if (file-exists (string dir "/" f))
            (load (string dir "/" f)))))
