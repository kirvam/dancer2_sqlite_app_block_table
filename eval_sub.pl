use strict;
use Data::Dumper;

my %hash;

#my $line = "none;Initiative;03-13-2020;Thing1;PMH;Spider Man fights King pin";
#my $ii="3";

my @array;
my @AoA = (
          [
            6,
            'none',
            'BLANK',
            'X3',
            'BLANK',
            '03-18-2020',
            'PMH',
            'Extra X.<br>'
          ],
          [
            10,
            'none',
            'Initiative',
            '4 Thing4',
            'Initiative',
            '04-06-2020',
            'PMH',
            'Spider Man and Venom.'
          ],
          [
            8,
            'none',
            'Initiative',
            '3 Thing3',
            'Initiative',
            '04-01-2020',
            'PMH',
            'Adding Thing3<br>'
          ],
          [
            9,
            '3 Thing3',
            'Initiative',
            '3 Thing3',
            'Initiative',
            'Thing3',
            'PMH',
            'test'
          ],
          [
            3,
            'none',
            'Initiative',
            '2 Thing2',
            'Initiative',
            '03-13-2020',
            'PMH',
            'Starting, Spider Man fights King pin'
          ],
          [
            4,
            '2 Thing2',
            'Project',
            '2 Thing2',
            'Project',
            '03-14-2020',
            'PMH',
            'Starting part 2.<br>'
          ],
          [
            7,
            '2 Thing2',
            'Project',
            '2 Thing2',
            'Project',
            '04-07-2020',
            'PMH',
            'Starting part 4.<br>'
          ],
          [
            1,
            'none',
            'Initiative',
            '1 Thing1',
            'Initiative',
            '03-13-2020',
            'PMH',
            'Spider Man fights King pin<br>'
          ],
          [
            2,
            '1 Thing1',
            'BLANK',
            '1 Thing1',
            'BLANK',
            '03-13-2020',
            'PMH',
            'Still working.<br>'
          ],
          [
            5,
            '1 Thing1',
            'BLANK',
            '1 Thing1',
            'BLANK',
            '03-18-2020',
            'PMH',
            'Working on this.<br>'
          ]
);

print "---< Start >---\n";
my(@AoA) = _create_AoA_();
print "Dumper \@AoA\n";
print Dumper \@AoA;

#exit;
print "Running: for_while_loop_2(\@AoA)\n";
for_while_loop_2(@AoA);

print "---< End >---\n";


#################################
sub for_while_loop_2{
print "SUB: start  for_while_loop_2\n";
my(@AoA) = @_;
  print "s for_while Dumper\n";
   #print Dumper \@AoA;
  print "e for_while Dumper\n";
my $jj = 1;
for my $i ( 0 .. $#AoA ){
    my $line;
    for my $j ( 0 .. $#{$AoA[$i]} ){
          if ( $j eq 0 ){
          $line = $AoA[$i][$j];
         } else {
           $line = $line."; ".$AoA[$i][$j];
        };
       chomp($line);
       $line = cleaner2($line)
     };
       print "==== \$jj: \$line =========\n";
       print "$jj: $line\n";
       $jj++;
       evaluateLine($line,$jj);
       print "Dumper \%hash\n";
       print Dumper \%hash;
   };
print "SUB: end  for_while_loop_2\n";
};


sub evaluateLine {
print "SUB: evaluateLine\n";
my ($line,$ii) = @_;

my $actions = {
               'none' => sub { my $key = "1"; $hash{ $array[3] }{$key} = [ @array ]; },
               'HAS_PARENT' => sub { $ii++; my $key = create_entry_time(); $key = $key + $ii; $hash{ $array[0] }{$key} = [ @array ]; },
               '_DEFAULT_' => sub { die "Unrecognized token '$_[0]'; aborting\n" }
};
###
  chomp($line);
 ### chomp($_[0]);
  print "\$line: $line\n";

  @array = split(/\;\s+/,$line);
  # clean: split(/\;\s?/
  shift @array;  # remove first element
  my $type;
  if($array[0] =~ m/^(none)$/){
       $type = $1;
       print "$ii: \$type: ^$type^ | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
   } else {
       $type = 'HAS_PARENT';
      print "$ii: \$type: not parent ^$type^ | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
  };
       my $action = $actions->{$type}
             #|| $actions ->{$hash{ $array[0] }}
             || $actions ->{_DEFAULT_};
        $action->($array[0], $type, $actions);
print "SUB CL: evaluateLine\n";
};


###
sub create_entry_time {
  my $entryTime = time();
    print "=== time entry: $entryTime === \n\n";
     return($entryTime);
};
#

sub cleaner2{
my($item)=@_;
 if($item =~ m/0xE2/g){
    print "found quote -replace with &quot\n";
    $item =~ s/0xE2/&quot/g;
  };
 print "cleaner: $item\n";
 return $item;
};


sub _create_AoA_{
print "--- start _create_AoA_ ---\n";
my @AoA;
while(<DATA>){
 my $line = $_;
 chomp($line);
 print "=== _create_AoA_: $line\n";
 my @array = split(/ *;;*/,$line);
 push @AoA, [ @array ];
 }
print "--- end _create_AoA_ ---\n";
return(@AoA);
};

#__DATA__
#none;Initiative;03-13-2020;1 Thing1;PMH;Spider Man fights King pin
#1 Thing1;BLANK;03-13-2020;1 Thing1;PMH;Still working.
#none;Initiative;03-13-2020;2 Thing2;PMH;Starting Thing 2.
#2 Thing2;Project;03-14-2020;2 Thing2;PMH;Starting part 2.
#1 Thing1;BLANK;03-18-2020;1 Thing1;PMH;Working on this.
#none;BLANK;03-18-2020;X3;PMH;Extra X.
#2 Thing2;Project;04-07-2020;2 Thing2;PMH;Starting part 4.
#none;Initiative;04-01-2020;3 Thing3;PMH;Adding Thing3
#3 Thing3;Initiative;Thing3;3 Thing3;PMH;test
#


__DATA__
1;none;Initiative;03-13-2020;Thing1;PMH;Spider Man fights King pin
2;Thing1;BLANK;03-13-2020;Thing1;PMH;Still working.
3;none;Initiative;03-13-2020;Thing2;PMH;Starting Thing 2.
4;Thing2;Project;03-14-2020;Thing2;PMH;Starting part 2.
5;Thing1;BLANK;03-18-2020;Thing1;PMH;Working on this.
6;none;BLANK;03-18-2020;X3;PMH;Extra X.
11;Thing2;Project;04-07-2020;Thing2;PMH;Starting part 4.
12;none;Initiative;04-01-2020;Thing3;PMH;Adding Thing3
13;Thing3;Initiative;Thing3;Thing3;PMH;test
