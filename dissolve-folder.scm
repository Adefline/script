#! /usr/bin/env chez-scheme
(define (dissolve-folder folder-path)
  (define folder-name (path->string (path->name folder-path)))
  (define parent-path (path->directory folder-path))
  (define files (directory-list folder-path))
  (for-each (lambda (file)
              (let ((file-path (path->string file)))
                (if (directory-exists? file-path)
                    (dissolve-folder (string->path file-path))
                    (rename-file file-path
                                  (path->string (combine-paths parent-path (path->name file)))))))
            files)
  (delete-directory folder-path #t)
  (display (string-append "Folder " folder-name " has been dissolved.\n")))
