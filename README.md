LICENSE HEADER SCRIPT
===========

##DESCRIPTION
----------
It's a simply bash script to automatically modify your source code files to add/modify their license header
it can:
* add to the source code files in the same folder the license set in the file License_header
* remove x lines of license in the source code files it there already is any Copyright notice

Be careful:
* it removes lines of copyright if it detects (by grep command) the Copyright word (if you have some code with the "Copyright" word it will mess the file.)(also it won't work if the previous or the License_header has no the "Copyright" word inside)
* once you remove the old copyright notice you have to restart the script to write the new one

##USAGE
------------
> sh header_Script.sh License_header
