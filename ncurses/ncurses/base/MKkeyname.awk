# $Id: MKkeyname.awk,v 1.1.1.1 2001/11/29 20:40:57 jevans Exp $
##############################################################################
# Copyright (c) 1999,2000,2001 Free Software Foundation, Inc.                #
#                                                                            #
# Permission is hereby granted, free of charge, to any person obtaining a    #
# copy of this software and associated documentation files (the "Software"), #
# to deal in the Software without restriction, including without limitation  #
# the rights to use, copy, modify, merge, publish, distribute, distribute    #
# with modifications, sublicense, and/or sell copies of the Software, and to #
# permit persons to whom the Software is furnished to do so, subject to the  #
# following conditions:                                                      #
#                                                                            #
# The above copyright notice and this permission notice shall be included in #
# all copies or substantial portions of the Software.                        #
#                                                                            #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    #
# THE ABOVE COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        #
# DEALINGS IN THE SOFTWARE.                                                  #
#                                                                            #
# Except as contained in this notice, the name(s) of the above copyright     #
# holders shall not be used in advertising or otherwise to promote the sale, #
# use or other dealings in this Software without prior written               #
# authorization.                                                             #
##############################################################################
BEGIN {
	print "/* generated by MKkeyname.awk */"
	print ""
	print "#include <curses.priv.h>"
	print "#include <tic.h>"
	print ""
	print "const struct kn _nc_key_names[] = {"
}

/^[^#]/ {
	printf "\t{ \"%s\", %s },\n", $1, $1;
	}

END {
	printf "\t{ 0, 0 }};\n"
	print ""
	print "NCURSES_EXPORT(NCURSES_CONST char *) keyname (int c)"
	print "{"
	print "static char **table;"
	print "int i;"
	print "char name[20];"
	print "char *p;"
	print ""
	print "\tfor (i = 0; _nc_key_names[i].name != 0; i++)"
	print "\t\tif (_nc_key_names[i].code == c)"
	print "\t\t\treturn (NCURSES_CONST char *)_nc_key_names[i].name;"
	print "\tif (c >= 256) return \"UNKNOWN KEY\";"
	print ""
	print "\tif (table == 0)"
	print "\t\ttable = typeCalloc(char *, 256);"
	print "\tif (table == 0)"
	print "\t\treturn keyname(256);"
	print ""
	print "\tif (table[c] == 0) {"
	print "\t\tp = name;"
	print "\t\tif (c >= 128) {"
	print "\t\t\tstrcpy(p, \"M-\");"
	print "\t\t\tp += 2;"
	print "\t\t\tc -= 128;"
	print "\t\t}"
	print "\t\tif (c < 0)"
	print "\t\t\tsprintf(p, \"%d\", c);"
	print "\t\telse if (c < 32)"
	print "\t\t\tsprintf(p, \"^%c\", c + '@');"
	print "\t\telse if (c == 127)"
	print "\t\t\tstrcpy(p, \"^?\");"
	print "\t\telse"
	print "\t\t\tsprintf(p, \"%c\", c);"
	print "\t\ttable[c] = strdup(name);"
	print "\t}"
	print "\treturn (NCURSES_CONST char *)table[c];"
	print "}"
}
