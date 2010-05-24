; written by Mark Huetsch
; same license as Arc

(def matchsplit (pat str)
  (let pos (posmatch pat str)
    (if pos
	    (list (cut str 0 pos) (cut str (+ 1 pos)))
	    (list str))))

(def joinstr (lst (o glue " "))
  (string (intersperse glue lst)))

(mac pushend (elem lst)
  `(= ,lst (join ,lst (list ,elem))))

(def begins-rest (pattern s)
  (if (begins s pattern)
    (cut s len.pattern)))

($ (require openssl))
($ (xdef ssl-connect (lambda (host port)
                       (ar-init-socket
                         (lambda () (ssl-connect host port))))))

(def parse-server-cookies (s)
  (map [map trim _]
       (map [matchsplit "=" _]
            (tokens s #\;))))

(def read-headers ((o s (stdin)))
  (accum a
    (whiler line (readline s) blank
      (a line))))

(def parse-server-headers (lines)
  (let http-response (tokens car.lines)
    (list
      (map http-response '(0 1 2))
      (some [aand (begins-rest "Set-Cookie:" _) parse-server-cookies.it]
            cdr.lines))))

(def args->query-string (args)
  (if args
    (let equals-list (map [joinstr _ "="] (pair (map [coerce _ 'string] args)))
      (joinstr equals-list "&"))
    ""))

(def parse-url (url)
  (withs ((resource url)    (split-at "://" (ensure-resource:strip-after url "#"))
          (host+port path+query)  (split-at "/" url)
          (host portstr)    (split-at ":" host+port)
          (path query)      (split-at "?" path+query))
    (obj resource resource
         host     host
         port     (or (only.int portstr) default-port.resource)
         filename path
         query    query)))

; TODO: only handles https for now
(def default-port(resource)
  (if (is resource "https")
    443
    80))

(def encode-cookie (o)
  (let joined-list (map [joinstr _ #\=] (tablist o))
    (+ "Cookie: "
       (if (len> joined-list 1)
         (reduce (fn(x y)(+ x "; " y)) joined-list)
         (car joined-list))
       ";")))

; TODO this isn't very pretty
(def get-or-post-url (url (o args) (o method "GET") (o cookie))
  (withs (method            (upcase method)
          parsed-url        (parse-url url)
          args-query-string (args->query-string args)
          full-args         (joinstr (list args-query-string (parsed-url 'query)) "&")
          request-path      (+ "/" (parsed-url 'filename)
                               (if (and (is method "GET") (> (len full-args) 0))
                                   (+ "?" full-args)))
          header-components (list (+ method " " request-path " HTTP/1.0")
                                  (+ "Host: " (parsed-url 'host))
                                  "User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; uk; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2"))
    (when (is method "POST")
      (pushend (+ "Content-Length: "
                  (len (utf-8-bytes full-args)))
               header-components)
      (pushend "Content-Type: application/x-www-form-urlencoded"
               header-components))
    (when cookie
      (push (encode-cookie cookie) header-components))
    (withs (header          (reduce (fn(x y) (+ x "\r\n" y)) header-components)
            body            (if (is method "POST") (+ full-args "\r\n"))
            request-message (+ header "\r\n\r\n" body))
      (let (in out) (if (is "https" (parsed-url 'resource))
                      (ssl-connect (parsed-url 'host) (parsed-url 'port))
                      (socket-connect (parsed-url 'host) (parsed-url 'port)))
        (disp request-message out)
        (with (header (parse-server-headers (read-headers in))
               body   (tostring (whilet line (readline in) (prn line))))
          (close in out)
          (list header body))))))

(def get-url (url (o cooks))
  ((get-or-post-url url nil "GET" cooks) 1))

(def post-url (url args (o cooks))
  ((get-or-post-url url args "POST" cooks) 1))



(def split-at(delim s)
  (iflet idx (posmatch delim s)
    (list (cut s 0 idx) (cut s (+ idx len.delim)))
    (list s nil)))

(def strip-after(s delim)
  ((split-at delim s) 0))

(def ensure-resource(url)
  (if (posmatch "://" url)
    url
    (+ "http://" url)))
