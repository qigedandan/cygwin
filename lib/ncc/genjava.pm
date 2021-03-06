# This file is part of the nesC compiler.
#    Copyright (C) 2002 Intel Corporation
# 
# The attached "nesC" software is provided to you under the terms and
# conditions of the GNU General Public License Version 2 as published by the
# Free Software Foundation.
# 
# nesC is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with nesC; see the file COPYING.  If not, write to
# the Free Software Foundation, 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.

true;

sub gen() {
    my ($classname, @spec) = @_;

    require migdecode;
    &decode(@spec);

    &usage("no classname name specified") if !defined($java_classname);

    $java_extends = "net.tinyos.message.Message" if !defined($java_extends);
    # See if name has a package specifier
    if ($java_classname =~ /(.*)\.([^.]*)$/) {
	$package = $1;
	$java_classname = $2;
    }

    print "/**\n";
    print " * This class is automatically generated by mig. DO NOT EDIT THIS FILE.\n";
    print " * This class implements a Java interface to the '$java_classname'\n";
    print " * message type.\n";
    print " */\n\n";

    print "package $package;\n\n" if $package;

    print "public class $java_classname extends $java_extends {\n\n";

    print "    /** The default size of this message type in bytes. */\n";
    print "    public static final int DEFAULT_MESSAGE_SIZE = $size;\n\n";

    print "    /** The Active Message type associated with this message. */\n";
    print "    public static final int AM_TYPE = $amtype;\n\n";

    print "    /** Create a new $java_classname of size $size. */\n";
    print "    public $java_classname() {\n";
    print "        super(DEFAULT_MESSAGE_SIZE);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /** Create a new $java_classname of the given data_length. */\n";
    print "    public $java_classname(int data_length) {\n";
    print "        super(data_length);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /**\n";
    print "     * Create a new $java_classname with the given data_length\n";
    print "     * and base offset.\n";
    print "     */\n";
    print "    public $java_classname(int data_length, int base_offset) {\n";
    print "        super(data_length, base_offset);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /**\n";
    print "     * Create a new $java_classname using the given byte array\n";
    print "     * as backing store.\n";
    print "     */\n";
    print "    public $java_classname(byte[] data) {\n";
    print "        super(data);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /**\n";
    print "     * Create a new $java_classname using the given byte array\n";
    print "     * as backing store, with the given base offset.\n";
    print "     */\n";
    print "    public $java_classname(byte[] data, int base_offset) {\n";
    print "        super(data, base_offset);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /**\n";
    print "     * Create a new $java_classname using the given byte array\n";
    print "     * as backing store, with the given base offset and data length.\n";
    print "     */\n";
    print "    public $java_classname(byte[] data, int base_offset, int data_length) {\n";
    print "        super(data, base_offset, data_length);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /**\n";
    print "     * Create a new $java_classname embedded in the given message\n";
    print "     * at the given base offset.\n";
    print "     */\n";
    print "    public $java_classname(net.tinyos.message.Message msg, int base_offset) {\n";
    print "        super(msg, base_offset, DEFAULT_MESSAGE_SIZE);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /**\n";
    print "     * Create a new $java_classname embedded in the given message\n";
    print "     * at the given base offset and length.\n";
    print "     */\n";
    print "    public $java_classname(net.tinyos.message.Message msg, int base_offset, int data_length) {\n";
    print "        super(msg, base_offset, data_length);\n";
    print "        amTypeSet(AM_TYPE);\n";
    print "    }\n\n";

    print "    /**\n";
    print "    /* Return a String representation of this message. Includes the\n";
    print "     * message type name and the non-indexed field values.\n";
    print "     */\n";
    print "    public String toString() {\n";
    print "      String s = \"Message <$java_classname> \\n\";\n";
    for (@fields) {
	($field, $type, $bitlength, $offset, $amax, $abitsize, $aoffset) = @{$_};
        print "      try {\n";
	$javafield = $field;
	$javafield =~ s/\./_/g;
	if (!@$amax) {
	  ($javatype, $java_access, $arrayspec) = &javabasetype($type, $bitlength, 0);
	  if ($javatype eq "float") {
	    print "        s += \"  [$field=\"+Float.toString(get_$javafield())+\"]\\n\";\n";
	  } else {
	    print "        s += \"  [$field=0x\"+Long.toHexString(get_$javafield())+\"]\\n\";\n";
	  }
	} elsif (@$amax == 1 && $$amax[0] != 0) {
	  ($javatype, $java_access, $arrayspec) = &javabasetype($type, $bitlength, @$amax);
          print "        s += \"  [$field=\";\n";
          print "        for (int i = 0; i < $$amax[0]; i++) {\n";
	  if ($javatype eq "float") {
	    print "          s += Float.toString(getElement_$javafield(i))+\" \";\n";
	  } else {
	    if ($bitlength > 32) {
	      print "          s += \"0x\"+Long.toHexString(getElement_$javafield(i))+\" \";\n";
	    }
	    elsif (bitlength > 16) {
	      print "          s += \"0x\"+Long.toHexString(getElement_$javafield(i) & 0xffffffff)+\" \";\n";
	    }
	    elsif (bitlength > 8) {
	      print "          s += \"0x\"+Long.toHexString(getElement_$javafield(i) & 0xffff)+\" \";\n";
	    }
	    else {
	      print "          s += \"0x\"+Long.toHexString(getElement_$javafield(i) & 0xff)+\" \";\n";
	    }
	  }
          print "        }\n";
          print "        s += \"]\\n\";\n";
	}
        print "      } catch (ArrayIndexOutOfBoundsException aioobe) { /* Skip field */ }\n";
    }
    print "      return s;\n";
    print "    }\n\n";

    print "    // Message-type-specific access methods appear below.\n\n";
    for (@fields) {
	($field, $type, $bitlength, $offset, $amax, $abitsize, $aoffset) = @{$_};

        # Determine if array
	if (@$amax) {
	  $isarray = 1;
	  $arraydims = @$amax;
	  $arraysize_bits = $$amax[0] * $$abitsize[0];
	  $index = 0;
	  @args = map { $index++; "int index$index" } @{$amax};
	  $argspec = join(", ", @args);
	  $index = 0;
	  @passargs = map { $index++; "index$index" } @{$amax};
	  $passargs = join(", ", @passargs);
	} else {
	  $isarray = 0;
	  $arraydims = 0;
	  $arraysize_bits = 0;
	  $argspec = "";
	  $passargs = "";
	}

        # Determine if signed
	if ($basetype eq "U" || $basetype eq "BU") {
	  $signed = 0; $signedstr = ", unsigned";
	} elsif ($basetype eq "I" || $basetype eq "BI") {
	  $signed = 1; $signedstr = ", signed";
	} elsif ($basetype eq "F" || $basetype eq "D" || $basetype eq "LD") {
	  $signed = 1; $signstr = "";
	}

        # Get field type and accessor
	$javafield = $field;
	$javafield =~ s/\./_/g;
	($javatype, $java_access, $arrayspec) = &javabasetype($type, $bitlength, $arraydims);

	print "    /////////////////////////////////////////////////////////\n";
	print "    // Accessor methods for field: $field\n";
	if ($isarray) {
	  print "    //   Field type: $javatype$arrayspec$signedstr\n";
	  print "    //   Offset (bits): $offset\n";
	  print "    //   Size of each element (bits): $bitlength\n";
	} else {
	  print "    //   Field type: $javatype$signedstr\n";
	  print "    //   Offset (bits): $offset\n";
	  print "    //   Size (bits): $bitlength\n";
	}
	print "    /////////////////////////////////////////////////////////\n\n";
        ### isSigned
	if ($signed) { $strue = "true"; } else { $strue = "false"; }
	print "    /**\n";
	print "     * Return whether the field '$field' is signed ($strue).\n";
	print "     */\n";
	print "    public static boolean isSigned_$javafield() {\n";
	print "        return $strue;\n";
	print "    }\n\n";

        ### isArray
	if ($isarray) { $atrue = "true"; } else { $atrue = "false"; }
	print "    /**\n";
	print "     * Return whether the field '$field' is an array ($atrue).\n";
	print "     */\n";
	print "    public static boolean isArray_$javafield() {\n";
	print "        return $atrue;\n";
	print "    }\n\n";

        ### Offset
	print "    /**\n";
	print "     * Return the offset (in bytes) of the field '$field'\n";
	if ((int($offset) % 8) != 0) {
	  print "     * WARNING: This field is not byte-aligned (bit offset $offset).\n";
	}
	print "     */\n";

	print "    public static int offset_$javafield($argspec) {\n";
	if ($isarray) {
	    printoffset($offset, $amax, $abitsize, $aoffset, 0);
	} else {
	    print "        return ($offset / 8);\n";
	}
	print "    }\n\n";

	print "    /**\n";
	print "     * Return the offset (in bits) of the field '$field'\n";
	print "     */\n";
	print "    public static int offsetBits_$javafield($argspec) {\n";
	if ($isarray) {
	  printoffset($offset, $amax, $abitsize, $aoffset, 1);
	} else {
	  print "        return $offset;\n";
	}
	print "    }\n\n";


	if (!$isarray) {
	  ### For non-array fields

          ### Get
  	  print "    /**\n";
  	  print "     * Return the value (as a $javatype) of the field '$field'\n";
  	  print "     */\n";
  	  print "    public $javatype get_$javafield() {\n";
  	  print "        return ($javatype)get$java_access(offsetBits_$javafield(), $bitlength);\n";
  	  print "    }\n\n";

          ### Set
  	  print "    /**\n";
  	  print "     * Set the value of the field '$field'\n";
  	  print "     */\n";
  	  print "    public void set_$javafield($javatype value) {\n";
  	  print "        set$java_access(offsetBits_$javafield(), $bitlength, value);\n";
  	  print "    }\n\n";

          ### Size
  	  print "    /**\n";
	  print "     * Return the size, in bytes, of the field '$field'\n";
	  if ((int($bitlength) % 8) != 0) {
	    print "     * WARNING: This field is not an even-sized number of bytes ($bitlength bits).\n";
	  } 
	  print "     */\n";
	  print "    public static int size_$javafield() {\n";
	  if ((int($bitlength) % 8) != 0) {
  	    print "        return ($bitlength / 8) + 1;\n";
	  } else {
  	    print "        return ($bitlength / 8);\n";
          }
	  print "    }\n\n";

  	  print "    /**\n";
	  print "     * Return the size, in bits, of the field '$field'\n";
	  print "     */\n";
	  print "    public static int sizeBits_$javafield() {\n";
	  print "        return $bitlength;\n";
	  print "    }\n\n";

	} else {
          ### For array fields

          ### Get
  	  print "    /**\n";
  	  print "     * Return the entire array '$field' as a $javatype$arrayspec\n";
  	  print "     */\n";
  	  print "    public $javatype$arrayspec get_$javafield() {\n";
	  &printarrayget($javafield, $javatype, $arrayspec, $bitlength, $amax, $abitsize);
  	  print "    }\n\n";

          ### Set
  	  print "    /**\n";
  	  print "     * Set the contents of the array '$field' from the given $javatype$arrayspec\n";
  	  print "     */\n";
  	  print "    public void set_$javafield($javatype$arrayspec value) {\n";
	  &printarrayset($javafield, $javatype, $arrayspec, $bitlength, $amax, $abitsize);
  	  print "    }\n\n";

          ### GetElement
  	  print "    /**\n";
  	  print "     * Return an element (as a $javatype) of the array '$field'\n";
  	  print "     */\n";
  	  print "    public $javatype getElement_$javafield($argspec) {\n";
  	  print "        return ($javatype)get$java_access(offsetBits_$javafield($passargs), $bitlength);\n";
  	  print "    }\n\n";

          ### SetElement
  	  print "    /**\n";
  	  print "     * Set an element of the array '$field'\n";
  	  print "     */\n";
  	  print "    public void setElement_$javafield($argspec, $javatype value) {\n";
  	  print "        set$java_access(offsetBits_$javafield($passargs), $bitlength, value);\n";
  	  print "    }\n\n";

	  if ($arraysize_bits != 0) {
            ### Total size (when array size is known)
  	    print "    /**\n";
	    print "     * Return the total size, in bytes, of the array '$field'\n";
	    if ((int($arraysize_bits) % 8) != 0) {
  	      print "     * WARNING: This array is not an even-sized number of bytes ($arraysize_bits bits).\n";
	    } 
	    print "     */\n";
	    print "    public static int totalSize_$javafield() {\n";
	    print "        return ($arraysize_bits / 8);\n";
	    print "    }\n\n";

  	    print "    /**\n";
	    print "     * Return the total size, in bits, of the array '$field'\n";
	    print "     */\n";
	    print "    public static int totalSizeBits_$javafield() {\n";
	    print "        return $arraysize_bits;\n";
	    print "    }\n\n";
	  }

          ### Element size
	  print "    /**\n";
	  print "     * Return the size, in bytes, of each element of the array '$field'\n";
	  if ((int($bitlength) % 8) != 0) {
	    print "     * WARNING: This field is not an even-sized number of bytes ($bitlength bits).\n";
	  }
	  print "     */\n";
	  print "    public static int elementSize_$javafield() {\n";
	  print "        return ($bitlength / 8);\n";
	  print "    }\n\n";

	  print "    /**\n";
	  print "     * Return the size, in bits, of each element of the array '$field'\n";
	  print "     */\n";
	  print "    public static int elementSizeBits_$javafield() {\n";
	  print "        return $bitlength;\n";
	  print "    }\n\n";

          ### Number of dimensions
	  print "    /**\n";
	  print "     * Return the number of dimensions in the array '$field'\n";
	  print "     */\n";
	  print "    public static int numDimensions_$javafield() {\n";
	  print "        return $arraydims;\n";
	  print "    }\n\n";

          ### Number of elements
	  if ($arraydims == 1 && $$amax[0] != 0) {
            # For 1D arrays where the size of the array is known
  	    print "    /**\n";
	    print "     * Return the number of elements in the array '$field'\n";
	    print "     */\n";
	    print "    public static int numElements_$javafield() {\n";
	    print "        return $$amax[0];\n";
	    print "    }\n\n";
	  } 
	  print "    /**\n";
      	  print "     * Return the number of elements in the array '$field'\n";
	  print "     * for the given dimension.\n";
	  print "     */\n";
	  print "    public static int numElements_$javafield(int dimension) {\n";
	  print "      int array_dims[] = { ";
	  foreach $e (@$amax) { print "$e, "; }
	  print " };\n";
	  print "        if (dimension < 0 || dimension >= $arraydims) throw new ArrayIndexOutOfBoundsException();\n";
	  print "        if (array_dims[dimension] == 0) throw new IllegalArgumentException(\"Array dimension \"+dimension+\" has unknown size\");\n";
	  print "        return array_dims[dimension];\n";
	  print "    }\n\n";

          ### String conversions (for 1D arrays of 8-bit values)
	  if ($arraydims == 1 && $bitlength == 8) {
	      print "    /**\n";
	      print "     * Fill in the array '$field' with a String\n";
	      print "     */\n";
	      print "    public void setString_$javafield(String s) { \n";
	      if ($amax[0] != 0) {
                print "         int len = Math.min(s.length(), $$amax[0]-1);\n";
	      } else {
                print "         int len = s.length();\n";
	      }
	      print "         int i;\n";
	      print "         for (i = 0; i < len; i++) {\n";
	      print "             setElement_$javafield(i, ($javatype)s.charAt(i));\n";
              print "         }\n";
	      print "         setElement_$javafield(i, ($javatype)0); //null terminate\n";
	      print "    }\n\n";

  	      print "    /**\n";
 	      print "     * Read the array '$field' as a String\n";
	      print "     */\n";
	      print "    public String getString_$javafield() { \n";
	      if ($$amax[0] == 0) {
                print "         char carr[] = new char[net.tinyos.message.Message.MAX_CONVERTED_STRING_LENGTH];\n";
	      } else {
                print "         char carr[] = new char[Math.min(net.tinyos.message.Message.MAX_CONVERTED_STRING_LENGTH,$$amax[0])];\n";
              }
	      print "         int i;\n";
	      print "         for (i = 0; i < carr.length; i++) {\n";
	      print "             if ((char)getElement_$javafield(i) == (char)0) break;\n";
	      print "             carr[i] = (char)getElement_$javafield(i);\n";
              print "         }\n";
              print "         return new String(carr,0,i);\n";
	      print "    }\n\n";
	  }
	}
    }

    print "}\n";
}

sub javabasetype()
{
    my ($basetype, $bitlength, $arraydims) = @_;
    my $jtype, $acc;

    # Pick the java type whose range is closest to the corresponding C type
    if ($basetype eq "U" || $basetype eq "BU") {
      $acc = "UIntElement" if $basetype eq "U";
      $acc = "UIntBEElement" if $basetype eq "BU";
      if ($bitlength < 8) { $jtype = "byte"; }
      elsif ($bitlength < 16) { $jtype = "short"; }
      elsif ($bitlength < 32) { $jtype = "int"; }
      else { $jtype = "long"; }
    }
    elsif ($basetype eq "I" || $basetype eq "BI") {
      $acc = "SIntElement" if $basetype eq "I";
      $acc = "SIntBEElement" if $basetype eq "BI";
      if ($bitlength <= 8) { $jtype = "byte"; }
      elsif ($bitlength <= 16) { $jtype = "short"; }
      elsif ($bitlength <= 32) { $jtype = "int"; }
      else { $jtype = "long"; }
    }
    elsif ($basetype eq "F" || $basetype eq "D" || $basetype eq "LD") {
      $acc = "FloatElement";
      $jtype = "float";
    }

    if ($arraydims > 0) {
      # For array types
      $arrayspec = "";
      for ($i = 0; $i < $arraydims; $i++) {
	$arrayspec = "[]" . $arrayspec;
      }
    } 

    return ($jtype, $acc, $arrayspec);
}

sub printoffset()
{
    my ($offset, $max, $bitsize, $aoffset, $inbits) = @_;

    print "        int offset = $offset;\n";
    for ($i = 1; $i <= @$max; $i++) {
	# check index bounds. 0-sized arrays don't get an upper-bound check
	# (they represent variable size arrays. Normally they should only
	# occur as the first-dimension of the last element of the structure)
	if ($$max[$i - 1] != 0) {
	    print "        if (index$i < 0 || index$i >= $$max[$i - 1]) throw new ArrayIndexOutOfBoundsException();\n";
	}
	else {
	    print "        if (index$i < 0) throw new ArrayIndexOutOfBoundsException();\n";
	}
	print "        offset += $$aoffset[$i - 1] + index$i * $$bitsize[$i - 1];\n";
    }
    if ($inbits) {
      print "        return offset;\n";
    } else {
      print "        return (offset / 8);\n";
    }
}

sub printarrayget() {
  my ($javafield, $javatype, $arrayspec, $bitlength, $amax, $abitsize) = @_;

  # Check whether array has known size
  for ($i = 0; $i < @$amax; $i++) {
    if ($$amax[$i] == 0) {
      print "        throw new IllegalArgumentException(\"Cannot get field as array - unknown size\");\n";
      return;
    }
  }

  print "        $javatype$arrayspec tmp = new $javatype";
  for ($i = 0; $i < @$amax; $i++) {
    print "[$$amax[$i]]";
  }
  print ";\n";

  $indent = " ";
  for ($i = 0; $i < @$amax; $i++) {
    print "      $indent for (int index$i = 0; index$i < numElements_$javafield($i); index$i++) {\n";
    $indent = $indent . "  ";
  }
  $indent = $indent . "  ";
  print "      $indent tmp";
  for ($i = 0; $i < @$amax; $i++) {
    print "[index$i]";
  }
  print " = getElement_$javafield(";
  for ($i = 0; $i < @$amax; $i++) {
    print "index$i";
    if ($i != @$amax-1) { print ","; }
  }
  print ");\n";

  $indent = substr($indent, 0, length($indent)-2);
  for ($i = 0; $i < @$amax; $i++) {
    $indent = substr($indent, 0, length($indent)-2);
    print "      $indent }\n";
  }
  print "        return tmp;\n";
}

sub printarrayset() {
  my ($javafield, $javatype, $arrayspec, $bitlength, $amax, $abitsize) = @_;

  $indent = " ";
  $val = "";
  for ($i = 0; $i < @$amax; $i++) {
    print "      $indent for (int index$i = 0; index$i < value$val.length; index$i++) {\n";
    $val = $val . "[index$i]";
    $indent = $indent . "  ";
  }
  $indent = $indent . "  ";
  print "      $indent setElement_$javafield(";
  for ($i = 0; $i < @$amax; $i++) {
    print "index$i";
    if ($i != @$amax-1) { print ","; }
  }
  print ", value";
  for ($i = 0; $i < @$amax; $i++) {
    print "[index$i]";
  }
  print ");\n";

  $indent = substr($indent, 0, length($indent)-2);
  for ($i = 0; $i < @$amax; $i++) {
    $indent = substr($indent, 0, length($indent)-2);
    print "      $indent }\n";
  }
}




