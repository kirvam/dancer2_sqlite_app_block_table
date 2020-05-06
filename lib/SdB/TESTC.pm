package SdB::TESTC;

use Dancer2 appname => 'SdB::App';
#use Dancer2::Plugin::Database;
###
use DBI;
use File::Spec;
use File::Slurper qw/ read_text /;
use Template;
use Data::Dumper;
###

my %hash;
my @array;
my $flash;

get '/TESTC' => sub {
    my $db = connect_db();
    #my $sql = 'select id, parent, entryDate, category, title, text, status from entries order by id desc';
    ###my $sql = 'select id, parent, entryDate, title, entryDate, category, text, status from entries order by title desc';
    my $sql = 'select id, parent, entryDate, title, entryDate, category, text, status from entries order by id';

    #my $sql = 'select id, parent, entryDate, title, text, status from entries where id in (\'1\',\'2\',\'17\') order by id desc';
    #my $sqlParent = 'select distinct parent from entries';
    #my $sqlParent = 'select distinct parent from entries where parent not in (\'none\')';
    my $sqlParent = 'select title from entries where parent = \'none\'';

    # select parent from entries where parent not in ('none')
    my $sqlTitle = 'select distinct title from entries';

    my $sth = $db->prepare($sql) or die $db->errstr;
    $sth->execute or die $sth->errstr;

    my $stha = $db->prepare($sql) or die $db->errstr;
    $stha->execute or die $sth->errstr;

    my $sthParent = $db->prepare($sqlParent) or die $db->errstr;
    $sthParent->execute or die $sth->errstr;

    my $sthTitle = $db->prepare($sqlTitle) or die $db->errstr;
    $sthTitle->execute or die $sth->errstr;
    ###print "$sth->fetchall_hashref()\n\n";
    my $entries = $sth->fetchall_hashref('id');
    print Dumper \$entries;
    print "Finished dumping \$entries.\n";

    my $list = $stha->fetchall_arrayref();
    my $listParent = $sthParent->fetchall_arrayref();
    my $listTitle = $sthTitle->fetchall_arrayref();

    my $spectab = "<p><table><tr><td>dog</td><td>bat</td><td>cow</td></tr></table><p>\n";
    my $data = $entries;
     ###print Dumper $data;
    print Dumper \$list;
    print "Finished Dumping \$list.\n";
    print Dumper \$listParent;
    print "Finished Dumping \$listParent.\n";
    my $listDistinctParent = $listParent;
    print Dumper \$listDistinctParent;
    print "Finished Dumping \@listDistinctParent\n";
    print Dumper \$listTitle;
    print "Finished Dumping \$listTitle.\n";
     ###
my $html = q{};
my @AoA = ();
%hash = ();
@AoA = @{ $list };
my @AoAParent = @{ $listParent };
print Dumper \@AoA;
print "Finished Dumper \@AoA\n";
print Dumper \@AoAParent;
print "Finished Dumper \@AoAParent\n";

my @AoAarray;
foreach my $tt ( 0 .. $#AoAParent ) {
  foreach my $rr ( 0 .. $#{ $AoAParent[$tt] } ){
          print $AoAParent[$tt][$rr],"\n";
          if ( $rr eq 0 ) { push @AoAarray, $AoAParent[$tt][$rr];  };
        };
  };
###
## now case-insensitively
  my @dropDown = @AoAarray;
  #my @AoAarray = sort {fc($a) cmp fc($b)} @dropDown;
  my @AoAarray = sort @dropDown;
###
print "Dumping \@AoAarray\n";
print Dumper \@AoAarray;

my @array = qw( Project1 Project 2 ProjectX );
print Dumper \@array;
print "Finished Dumping \@array\n";
for_while_loop_2(@AoA);
#print "Dumper \%hash \n";
#print Dumper \%hash;
$html = style_ref_HoHoA_1_print_FH(\%hash,$html);
print "====== Dumper \%hash =======\n";
print Dumper \%hash;
print "====== Dumper \%hash =======\n";
     ###
    template 'show_testa.tt', {
                  'msg' => get_flash(),
        'add_entry_url' => uri_for('/add'),
       'edit_entry_url' => uri_for('/editnote'),
          #   'entries' => $sth->fetchall_hashref('id'),
              'entries' => $entries,
              'spectab' => $spectab,
                 'html' => $html,
           'listParent' => \@AoAParent,
   'listDistinctParent' => $listDistinctParent,
        #    'array' => \@array,
            'array' => \@AoAarray,
    };
};

######################################
### relies on these subs in the App.pm
# connect_db()
# for_while_loop_2
# style_ref_HoHoA_1_print_FH
#
######################################
###
sub get_flash {
    my $msg = $flash;
    $flash = "";
    return $msg;
}

###
sub style_ref_HoHoA_1_print_FH {
my($hash_ref,$html) = @_;
open  my ($fh), '>', \$html || die "Flaming death on open of $html: $! \n";
print "\n\n";
print $fh "<meta http-equiv=\"Content-type\" content=\"text/html; charset=<% settings.charset %>\" />\n";
print $fh "<title>CS Project Dashboard</title>\n";
print $fh "<!-- Grab jQuery from a CDN, fall back to local if necessary -->\n";
print $fh "<script src=\"//code.jquery.com/jquery-1.11.1.min.js\"></script>\n";
print $fh "<!-- End Comments -->\n";
print $fh "<style>\n";
print $fh "body {
    background-color: #ddd;
}
\n";
print $fh "\@media screen and (min-width: 480px) {
    body {
        background-color: cornflower;
    }
}\n";
print $fh "</style>\n";
my $big_string = "
    <!--
    <div class=page>
    -->
    <h1>CS Dashboard</h1>
       <div class=metanav>
    <!--
    </div>
    -->
  <ul class=entries>
  <table id=\"rounded-corner\" summary=\"Listing\">
\n";
print $fh "$big_string";
print $fh "<thead bgcolor=\"#ffd\">\n";
print $fh "<tr style=\"background-color:darkblue; color:white;\">\n";
print $fh "<td>Heading</td>\n";
print $fh "<td>Date</td>\n";
print $fh "<td>Staff</td>\n";
print $fh "<td>Note</td>\n";
print $fh "</tr>\n";
print $fh "</thead>\n";
foreach my $key ( sort keys %$hash_ref ){
         print $fh "<!-- Start Heading -->\n";
         print $fh "<tbody>\n";
         print $fh "  <tr style=\"background-color:#E6E6FA;color:black;\" class=\"flip\"; style=\"color:black;\">\n";
         print $fh "<td rowspan=\"4\">$key</td>\n";
         print $fh "</tr>\n";
         print $fh "</tbody>\n";
          my $count = 0;
         print $fh "  <tbody class=\"section\" style=\"display:none;\" bgcolor=\"#ffd\">\n";
          foreach my $entry ( reverse sort keys %{ $hash_ref->{$key} } ){
             if ($count le 3){
                    if ( $count == 0 ){
                    print $fh "<!-- Start Listing  $#array $count-->\n";
                       print $fh "  <tr style=\"background-color:yellow;color:black;\">\n";
                      $count++;
                       } elsif ( $count == 1 ){
                          print $fh "<!-- Flip Start $#array $count-->\n";
                          print $fh "  <tr style=\"background-color:lightblue;color:black\">\n";
                          $count++;
                        }  else {
                           print $fh "  <tr style=\"background-color:lightblue;color:black\">\n";
                           $count++;
                     };
              my @array =  $hash_ref->{$key}->{$entry} ;
                  for my $i ( 0 .. $#array ) {
                    for my $j ( 3 .. $#{ $array[$i] } ) {
                     print $fh "  <td>$array[$i][$j]</td>\n";
                   }
             print $fh " </tr>\n";
                };
           } else {
               next;
        };

     print $fh "\n";
   };
     print $fh " </tbody>\n";
     print $fh "<!-- End -->\n";
 };
my $script = "<script>
\$('.flip').click(function() {
    \$(this)
        .closest('tbody')
        .next('.section')
        .toggle('fast');
});
</script>
";
 print $fh "$script\n";
 print $fh "</table>\n";
 print $fh "</div>\n";
 print $fh "<div id=\"footer\">
Powered by <a href=\"http://perldancer.org/\">Dancer2</a> 0.205001
</div>\n";
 print $fh "</body>\n";
 print $fh "</html>\n";
 print $fh "\n\n";
 return ($html);
};

###
sub connect_db {
    my $dbh = DBI->connect("dbi:SQLite:dbname=".setting('database')) or
        die $DBI::errstr;
    return $dbh;
}
###
sub cleaner2{
my($item)=@_;
 if($item =~ m/0xE2/g){
    print "found quote -replace with &quot\n";
    $item =~ s/0xE2/&quot/g;
  };
 print "cleaner: $item\n";
 return $item;
};
###
sub for_while_loop_2{
print "SUB:  for_while_loop_2\n";
my(@AoA) = @_;
  print "s for_while Dumper\n";
   print Dumper \@AoA;
  print "e for_while Dumper\n";
my $jj = 1;
for my $i ( 0 .. $#AoA ){
    my $line;
    for my $j ( 0 .. $#{$AoA[$i]} ){
          if ( $j eq 0 ){
          $line = $AoA[$i][$j];
           print "+++++++ $line\n";
         } else {
           $line = $line."; ".$AoA[$i][$j];
           print "======= $line\n";
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
print "SUB CL:  for_while_loop_2\n";
};
###
sub evaluateLine {
print "SUB: evaluateLine\n";
my ($line,$ii) = @_;
my $actions = {
               'none' => sub { my $key = "1"; $hash{ $array[2] }{$key} = [ @array ]; },
#               $hash{ $array[0] } => sub { $ii++; my $key = create_entry_time(); $key = $key + $ii; $hash{ $array[0] }{$key} = [ @array ]; },
               '_CHILD_ENTRY_' => sub { $ii++; my $key = create_entry_time(); $key = $key + $ii; $hash{ $array[0] }{$key} = [ @array ]; },
               '_DEFAULT_' => sub { die "Unrecognized token '$_[0]'; aborting\n" }
};
chomp($line);
print "\$line: $line\n";
@array = split(/\;\s+/,$line);
  shift @array;  # remove first element
  my $type;
  print "=== \$array[0] | $array[0] ====\n";
  if($array[0] =~ m/^(none)$/){
       $type = $1;
       print "$ii: \$type: ^$type^ | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
   } else {
       $type = "_CHILD_ENTRY_";
      print "$ii: \$type: not parent ^$type^ | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
  };
       my $action = $actions->{$type}
         #    || $actions ->{$hash{ $array[0] }}
             || $actions ->{_DEFAULT_};
        $action->($array[0], $type, $actions);
print "SUB CL: evaluateLine\n";
};
###
###
sub evaluateLineORG {
print "SUB: evaluateLine\n";
my ($line,$ii) = @_;
my $actions = {
               'none' => sub { my $key = "1"; $hash{ $array[2] }{$key} = [ @array ]; },
               $hash{ $array[0] } => sub { $ii++; my $key = create_entry_time(); $key = $key + $ii; $hash{ $array[0] }{$key} = [ @array ]; },
               '_DEFAULT_' => sub { die "Unrecognized token '$_[0]'; aborting\n" }
};
chomp($line);
print "\$line: $line\n";
@array = split(/\;\s+/,$line);
  shift @array;  # remove first element
  my $type;
  if($array[0] =~ m/^(none)$/){
       $type = $1;
       print "$ii: \$type: $type | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
   } else {
      print "$ii: \$type: not parent | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
  };
       my $action = $actions->{$type}
             || $actions ->{$hash{ $array[0] }}
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

###


1;



