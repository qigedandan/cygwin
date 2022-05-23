#

use strict;
use warnings;
use Getopt::Long;

filter();

sub filter
{
  my $file;
  
  GetOptions(
	  "file=s" => \$file,
  );
=pod
  print "Enter the file to be filtered:";
  $file = <STDIN>;
  chomp $file;
=cut
  
  #$file = "app.preMangle.c";
  
  open IN, $file or die "Error: can not open the file!";
  my @lines = <IN>;
  close IN;
  
  #my $filtered = 'filtered_' . $file;
  my $filtered = $file;
  open OUT, ">$filtered" or die "Error: can not open file!";
  open REC, ">log.txt" or die "Error: can not open file!";
  for (my $i = 0; $i < @lines; $i++)
  {
    my $line = $lines[$i];
    
    #inline static const  int /*comment*/ NodeM$StdOut$print(const char *arg_0x10bbb10){
    #inline static {type of return value and comment} {function name} {(void) | (one argument) | (first argument, second argument, ...)}
    if ($line =~ /\s*inline\s+static\s+(.*)(\s|\/|\*)((\w|\$|^\s)+)\((.+)\)\s*{/)    
    {
      my ($type_comment, $function, $string_arguments) = ($1, $3, $5);
      
      $function =~ s/\s+$//;

	  print "string_arguments=$string_arguments";
      
      my @arguments = split /,/, $string_arguments;
      my @names = ();
      get_names(\@names, \@arguments);
      
      my ($macro, $call) = (undef, undef);
      
      my $pos = $i;
      my @ref = ($i);
      my @block = ();
      #print "before get in block: i: $i\n";
      get_block(\@lines, \@ref, \@block);
      
      $i = $ref[0]; #change $i
      $call = $ref[1];
      
      if (is_more_calls(\@block) || is_switch_statement(\@block))
      {
        print REC "The $pos+1 line is_more_calls or is_switch_statement;\n";
        $i = $pos; #go back
        print OUT $lines[$i];
        
        next;
      }
      
      $macro = "#define $function(";
      

      for (my $j = 0; $j < @names; $j++) 
      {
        if ($j != $#names)
        {
          $macro .= "$names[$j],";
        }
        else
        {
          $macro .= "$names[$j]";
        }
      }
      
      $macro .= ") $call\n";
      print OUT $macro;
      print "macro: $macro\n";
    }
    elsif ($line =~ /\s*inline\s+static\s+(.*)(\s|\/|\*)((\w|\$|^\s)*)\((.+)\)\s*;/)  
    {
      # do not print $line into OUT  
    }
    else
    {
      print OUT $lines[$i];
    }
  }
  close REC;
  close OUT;    
}

###############################################################################
#Desc: get the function block
#$lines: ref to input file
#$i: ref to position in $lines
#$block: ref to the block cache
###############################################################################
sub get_block
{
  my ($lines, $ref, $block, $call) = @_;
  
  my $i = ${$ref}[0];
  print "after get in block: i: $i\n";
  for (; $i < @{$lines}; $i++)
  {
    push @{$block}, ${$lines}[$i];
    
    #/*CounterMilli32C.Transform*/TransformCounterC$0$CounterFrom$overflow();
    #get the function call
    if (${$lines}[$i] =~ /((\w|\$|^\s)+\(.*\));/)
    {
      $call = $1;
      
      $call =~ s/\/\*.*\*\///g; #filter all the comment in $call
      
      push @{$ref}, $call;
    }
    
    if (${$lines}[$i] =~ /\}/)
    {
      $i++; #get to the next line
      
      ${$ref}[0]= $i;      
      return;
    }
  }
}

###############################################################################
#Desc: get the names of arguments
#case 1:void
#case 2:type *name 
###############################################################################
sub get_names
{
  my ($names, $arguments) = @_;
  

  foreach (@{$arguments})  
  {
    s/^\s+|\s+$//g;
    
    #return if ($_ eq 'void'); #there are no arguments, only work on the first element
    
    if ($_ eq 'void')
    {
      push @{$names}, 'void';
      return;
    }
    if (/^(.*)(\s|\/|\*)((\w|\$)+)$/)
    {
      push @{$names}, $3;
    }
  }
}

###############################################################################
#Desc: do not deal with more than one call case
###############################################################################
sub is_more_calls
{
  my $block = shift @_;
  
  my $call = 0;
  
  foreach (@{$block})
  {
    if (/((\w|\$|^\s)+\(.*\));/)  
    {
      $call++;
    }
  }
  
  return $call > 1;
}

###############################################################################
#Desc: do not deal with switch case statement
###############################################################################
sub is_switch_statement
{
  my $block = shift @_;
  
  foreach (@{$block})
  {
    #switch (arg_0x17e84e8) {
    if (/^\s*switch/)
    {
      return 1;
    }    
  }
  
  return 0;
}