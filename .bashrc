# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

#-------------------------------------------------------------
 # Modular bash scripts
 #-------------------------------------------------------------

 # iterate over our bashrc script files
 for script in ~/.bash_files/*.sh
 do
   # echo $script
          # check if the script is executable
      if [ -x "${script}" ]; then
            # run the script
        source ${script}
      fi
 done

#hello
