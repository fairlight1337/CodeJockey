;;; CodeJockey.el --- Support coders when coding common constructs

;; Copyright (C) 2016 Jan Winkler.
;; Author: Jan Winkler <jan.winkler.84@gmail.com>
;; Version: 0.1
;; Package-Requires: ()
;; Keywords: development
;; URL: http://github.com/fairlight1337/CodeJockey


;;; Commentary:

;; Defines methods for auto-generating routine code from small amounts
;; of information.


;;;###autoload
;; Functions
(defun make-class-declaration (class-name namespace)
  (let* ((upcase-name (upcase class-name))
	 (definition (concat "__" upcase-name "_H__"))
	 (preamble (concat "#ifndef " definition "\n"
			   "#define " definition "\n"
			   "\n\n"
			   "#include <memory>\n"
			   "#include <iostream>\n"
			   "\n\n"))
	 (namespace-p (not (equal namespace "")))
	 (ns-indent (when namespace-p "  "))
	 (class-content
	  (concat (when namespace-p (concat "namespace " namespace " {\n"))
		  ns-indent "class " class-name " {\n"
		  ns-indent "  public:\n"
		  ns-indent "    typedef std::shared_ptr<" class-name "> Ptr;\n"
		  ns-indent "    \n"
		  ns-indent "  private:\n"
		  ns-indent "  protected:\n"
		  ns-indent "  public:\n"
		  ns-indent "    " class-name "();\n"
		  ns-indent "    ~" class-name "();\n"
		  ns-indent "    \n"
		  ns-indent "    template<class ... Args>\n"
		  ns-indent "      static " class-name "::Ptr create(Args ... args) {\n"
		  ns-indent "      return std::make_shared<" class-name ">(std::forward<Args>(args)...);\n"
		  ns-indent "    }\n";
		  ns-indent "};\n"
		  (when namespace-p "}\n")))
	 (postamble (concat "\n\n"
			    "#endif /* " definition " */\n")))
    (concat preamble class-content postamble)))

(defun make-class-implementation (class-name namespace)
  (let* ((namespace-p (not (equal namespace "")))
	 (ns-indent (when namespace-p "  ")))
    (concat "#include <" class-name ".h>\n"
	    "\n\n"
	    (when namespace-p (concat "namespace " namespace " {\n"))
	    ns-indent class-name "::" class-name "() {\n"
	    ns-indent "}\n\n"
	    ns-indent class-name "::~" class-name "() {\n"
	    ns-indent "}\n"
	    (when namespace-p "}\n"))))

(defun cj-make-class-declaration (class-name namespace)
  "The doc string"
  (interactive "sClass-name: \nsNamespace: ")
  (insert (make-class-declaration class-name namespace)))

(defun cj-make-class-implementation (class-name namespace)
  "The doc string"
  (interactive "sClass-name: \nsNamespace: ")
  (insert (make-class-implementation class-name namespace)))


;;; CodeJockey.el ends here
