 #!/usr/bin/perl
#Author Michael Vasquez
#CS 408
#
use strict;
use diagnostics;
use Entry;



package structure;

#create a list that will later be used as ptr to a hash table that will contain
#all entry objects 
#this is a global variable however it acts like a member variable within this package
#hence the use of "our" this in contrary to using "my" gives scope to within this 
#package
our $list;
our @entries;   # stores object of type Entry    

#****************************************************************
#AddEntry Method creates and validates new entry into addressbook
#Method to create a new entry into the addressbook
#theuser is asked a series of questions to complete every new 
#entry. Validation is done on each input field.
#If validation is correct entry is written to addressbook
#****************************************************************
sub sel{
	my $file= <STDIN>;
	chomp $file;
	my $entry = new Entry();
	$entry->write1($file);
}
sub AddEntry{

#create Entry class instance
my $entry =  new Entry();     
#set object attributes

print ( "Please enter in firstname: \n");
my $first = <STDIN>;
chomp $first;	#truncate newline char
$entry->firstName($first);

print ("Lastname: \n");
my $last = <STDIN>;
chomp $last;
$entry->lastName($last);

print("Home Phone: in the form xxx-xxx-xxxx \n");
	my $phone = <STDIN>;
	chomp $phone;
	
	my $test = validatePhone ($phone);
	if($test ne 0){
	my @values = search($test,3);
	#print ("$values[0]  \n");
	my $check = pop(@values);
	
        if ($check){
	print ("User already in Address Book\n\n");
	return 0;
	}else{
	$entry->phone($test);
	}
	}else{
	my $flag =0;
	while($flag == 0){
		errorMessage();
		my $newphone = prompt();
		#must dereference hard reference to get string value use $$ 
		my $test = validatePhone($$newphone);

                	if($test ne 0){
			chomp $test;
			my @values = search($test,3);
	
			my $check = pop(@values);
	
        		if ($check){
			print ("User already in Address Book\n\n");
			return 0;
			}else{
	
			$entry->phone($test);
 			$flag=1;
			}
			}#end of test

			if($flag == 1){ 

			{last;} #break out of loop if received correct input
			}
	}
}


print("Mobile phone in the form xxx-xxx-xxxx \n");
		my $mobile = <STDIN>;
		chomp $mobile;
		$test = validatePhone($mobile);
		if($test ne 0){
		$entry->mobile($test);
		}else{
		my $flag =0;
		while($flag == 0){
		errorMessage();
		my $newmobile = prompt();
		#must dereference hard reference to get string value use $$ 
		my $test = validatePhone($$newmobile);

                	if($test ne 0){
			chomp $test;
			
			$entry->mobile($test);
 			$flag=1;
			}#end of test

			if($flag == 1){ 

			{last;} #break out of loop if received correct input
			}
	}
}

print ("Home address: street,city and state\n");
my $address = <STDIN>;
chomp $address;
$entry->address($address);


print("Please enter a valid  Zipcode in the form xxxxx or xxxxx-xxxx \n");
my $zip = <STDIN>;
		chomp $zip;
		$test = validateZipcode($zip);
		if($test ne 0){
		$entry->zipcode($test);
		}else{
		my $flag =0;
		while($flag == 0){
		errorMessage();
		my $newzip = prompt();
		#must dereference hard reference to get string value use $$ 
		my $test = validateZipcode($$newzip);

                	if($test ne 0){
			chomp $test;
			
			$entry->zipcode($test);
 			$flag=1;
			}#end of test

			if($flag == 1){ 

			{last;} #break out of loop if received correct input
			}
	}
}

print("Please enter a valid Date of Birth in the form xx/xx/xxxx \n");
my $dob = <STDIN>;
		chomp $dob;
		$test = validateDate($dob);
		if($test ne 0){
		$entry->dob($test);
		}else{
		my $flag =0;
		while($flag == 0){
		errorMessage();
		my $newdate = prompt();
		#must dereference hard reference to get string value use $$ 
		my $test = validateDate($$newdate);

                	if($test ne 0){
			chomp $test;
			
			$entry->dob($test);
 			$flag=1;
			}#end of test

			if($flag == 1){ 

			{last;} #break out of loop if received correct input
			}
	}
}

print ("Please enter this persons yearly salary \n");
my $salary = <STDIN>;
chomp $salary;
$entry->salary($salary);


# write new Entry obj to a file specified in Entry Abstraction
#$entry->write();

push @entries, $entry;

  update();
}

#*****************************************************************
#
#Delete File 
#*****************************************************************

sub deleteFile{
    #create local output stream and write entry to file
    my $output="addressbook.txt";
    
    open(FH,">$output") || die("Cannot Open File");
    my ($self) = @_;
    
    close $output;
    close(FH);
    
}
#*****************************************************************
#Update method. Sort the Data Structure by first name as a final state 
#and write results to a file 
#****************************************************************

sub update{

my @sorted_entries;
deleteFile();
@sorted_entries = sort { $a->firstName cmp $b->firstName } @entries;

foreach(@sorted_entries){
$_->write();
}

}
#******************************************************************
#sorting routines
#All user to sort by all fields
#*****************************************************************

sub sort{
print("Please select field to sort by \n");
print("first name                1\n");
print("last name                 2\n");
print("Home phone                3\n");
print("Mobile phone              4\n");
print("Address                   5\n");
print("Zipcode                   6\n");
print("DOB                       7\n");
print("Salary                    8\n");

my @sorted_entries; 
my $select = <STDIN>;
#Store string of attribute we are sorting 
my @sortby;
$sortby[0]="First Name";
$sortby[1]="Last Name";
$sortby[2]="Home Phone";
$sortby[3]="Mobile Phone";
$sortby[4]="Address";
$sortby[5]="Zip code";
$sortby[6]="DOB";
$sortby[7]="Salary";
my @order = qw(Ascending Descending);
print("Ascending or Descending\n");
print("Ascending            1\n");
print("Descending           2\n");
my $direction =<STDIN>;



if( $select == 1 and $direction == 1){

@sorted_entries = sort { $a->firstName cmp $b->firstName } @entries;
}elsif( $select == 1 and $direction ==2 ){
@sorted_entries = sort { $b->firstName cmp $a->firstName } @entries;
}elsif( $select == 2 and $direction == 1){
@sorted_entries = sort { $a->lastName cmp $b->lastName } @entries;
}elsif($select == 2 and $direction == 2 ){
@sorted_entries = sort { $b->lastName cmp $a->lastName } @entries;
}elsif( $select == 3 and $direction == 1 ){
@sorted_entries = sort { $a->phone cmp $b->phone } @entries;
}elsif( $select == 3 and $direction == 2){
@sorted_entries = sort { $b->phone cmp $a->phone } @entries;
}elsif($select == 4 and $direction == 1 ){
@sorted_entries = sort { $a->mobile cmp $b->mobile } @entries;
}elsif( $select == 4 and $direction ==2 ){
@sorted_entries = sort { $b->mobile cmp $a->mobile } @entries;
}elsif( $select == 5 and $direction == 1){
@sorted_entries = sort { $a->Address cmp $b->Address } @entries;
}elsif($select == 5 and $direction == 2 ){
@sorted_entries = sort { $b->Address cmp $a->Address } @entries;
}elsif( $select == 6 and $direction ==1 ){
@sorted_entries = sort { $a->zipcode <=> $b->zipcode } @entries;
}elsif( $select == 6 and $direction == 2){
@sorted_entries = sort { $b->zipcode <=> $a->zipcode } @entries;
}elsif($select == 7 and $direction == 1 ){
@sorted_entries = sort { $a->dob cmp $b->dob } @entries;
}elsif( $select == 7 and $direction == 2 ){
@sorted_entries = sort { $b->dob cmp $a->dob } @entries;
}elsif( $select == 8 and $direction == 1){
@sorted_entries = sort { $a->salary <=> $b->salary } @entries;
}elsif($select == 8 and $direction == 2 ){
@sorted_entries = sort { $b->salary <=> $a->salary } @entries;
}

print ("Sorting by ", $sortby[$select-1]," in ",$order[$direction-1]," order\n\n");

#foreach my $value(@sorted_entries ){
  foreach(@sorted_entries){

	format SORTER= 
First Name: @<<<<<<<<<<<<<<<<<<<<<<<        Last Name: @>>>>>>>>>>>>>>>>>>
      $_->firstName,                                   $_->lastName
Home Phone: @<<<<<<<<<<<<<<<<<<<<<<<	    Mobile Phone: @>>>>>>>>>>>>>>>
      $_->phone,					  $_->mobile
Address:    @<<<<<<<<<<<<<<<<<<<<<<<	    Zip code:  @>>>>>>>>>>>>>>>>>>
      $_->address,			    	       $_->zipcode
DOB:	    @<<<<<<<<<<<<<<<<<<<<<<<	    Salary:    @###############.##
      $_->dob,					       $_->salary
        
.
write;

}
        

}


#******************************************************************
#Load a file and break each line up into tokens seperated by a delimiter
#in this case we will hard code the delimiter for the project to be a 
#colon. The method stores all records into a data structure for later
#processing.
#precondition: this method should only be used for intial loading of 
#the underlying data structure. The add method will also add new entries 
#to this data structure therefore calling of this method after an intial
#load would produce duplicate entries or possible loss of data
#precondition:All entries that are saved in a file have been validated 
#to meet criterion. It would be nice to do a second validation here or 
#runtime errors will be thrown if they are not specific to the Entry class
#***********************************************************************
sub load{
	#create a flag to find errors when loading 
	my $loaded = 0;
	my $tester;
	my $output=$_[0];
	#Get a filehandler for parsing input
	open (PWFILE,$output);
	while (<PWFILE>) {
    	chomp;
    	    my $loader = new Entry();
	    my @fields = split(":", $_);
	    #special case first and lastname are not required to be treated
            #seperate but do so for easier processing later
	    my @names = split(" ", $fields[0]);

            #load all class member variables taken from file
	    
	    $loader->firstName($names[0]);
	    $loader->lastName($names[1]);
            $loader->phone($fields[1]);
            $loader->mobile($fields[2]);
            #project specs stated to concatenate the address and zipcode as one 
            #long string when writing. Therefore we must break up that string when
            #reading it and get the zip code.No problem just use our validation code 
            #to find a valid zipcode in the string and add it to the class variable 
            #zipcode
            my @zip = split(" ",$fields[3]);
            my $mystr="";
  	    my $str=0;
            foreach $str (@zip){
		$tester = validateZipcode($str);
		if($tester ne 0){
		$loader->zipcode($tester);
		}else{
                $mystr.=$str ." ";
		}
	    }
            $loader->address($mystr);
	    $loader->dob($fields[4]);
            $loader->salary($fields[5]);

	    #validate document
            if($names[0] and $names[1] and $fields[1] and $fields[2] and $fields[3]
		 and $mystr and $tester){
		$loaded =1;
	     }else{
		$loaded =0;
	     }
            #put obj into array only if document is well formed 
            if ( $loaded == 1 ){
            push @entries,$loader;
	    }

	}#end while loop
}#end of load
#*******************************************************************
#
# Traverse the array of entry references. For now just print everything
# to screen.
#Using perl interpreter format schema see perl docs for details.
#@<<<<<<<<<<<<<<<<< means left justify
#@>>>>>>>>>>>>>>>>> means right justify
#@||||||||||||||||| means center justify
#*******************************************************************
sub traverse{
 my $counter=0;
foreach(@entries){

	format = 
First Name: @<<<<<<<<<<<<<<<<<<<<<<<        Last Name: @>>>>>>>>>>>>>>>>>>
      $_->firstName,                                   $_->lastName
Home Phone: @<<<<<<<<<<<<<<<<<<<<<<<	    Mobile Phone: @>>>>>>>>>>>>>>>
      $_->phone,					  $_->mobile
Address:    @<<<<<<<<<<<<<<<<<<<<<<<	    Zip code:  @>>>>>>>>>>>>>>>>>>
      $_->address,			    	       $_->zipcode
DOB:	    @<<<<<<<<<<<<<<<<<<<<<<<	    Salary:    @###############.##
      $_->dob,					       $_->salary
        
.
write;
$counter++;
}
	print ("Showing " . $counter . " record(s)\n\n");

}
#********************************************************************
# validation routines 
# Return 1 (true) correct format or return 0 false
#*******************************************************************
sub validatePhone {
my $fh =shift;
if($fh =~ /\d{3}-\d{3}-\d{4}/){
return $&;
}
else{
return 0;
}
}#end sub validatePhone


#********************************************************************
# validation routines 
# Return 1 (true) correct format or return 0 false
#*******************************************************************
sub validateZipcode {
   my $fh =shift;
if($fh =~ /(^\d{5}$)|(^\d{5}-\d{4}$)/){
return $&;
}
else{
return 0;
}
}#end sub validateZipcode

#********************************************************************
# validation routines 
# Return 1 (true) correct format or return 0 false
#*******************************************************************
sub validateDate {
   my $fh =shift;
if( $fh =~ /\b(1[0-2]|0?[1-9])[\-\/](0?[1-9]|[12][0-9]|3[01])[\-\/]((19|20)\d{2})/ ){

return $&;
}
else{
return 0;
}
}#end sub validateDate


#********************************************************************
#delete entrywise
#deletEntry
#uses the same technique as search but couples the searching algorithm
#with a spice function that deletes the an index into the array and 
#defrags the array to the appropriate size
#*******************************************************************
sub deleteEntry{

my $match = $_[0];
chop $match;
my $select = $_[1];
chop $select;
my $pos =0;
my @matches;
#print( $match );
#print( $select );
my $ans;
print("\n");
foreach (@entries){

	if ( $select == 1){
	 	if( $_->firstName eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		
		}
	}elsif( $select == 2){
		if($_->lastName eq $match) {
		$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 3 ) {
		if($_->phone eq $match ) {
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 4 ){
		if($_->mobile eq $match ){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif($select == 5 ){
		if($_->address eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 6 ){
		if($_->zipcode eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}elsif( $select == 7 ){
		if($_->salary eq $match){
			$_->showElement();
			print("Are sure you want to delete this entry?\n");
			print("Yes                 1\n");
			print("No                  2\n");
			$ans =<STDIN>;
			if($ans==1){
			splice(@entries,$pos,1);
			print("Deleting...... \n");
			}
		}
	}
$pos++;

}


return @matches;

}

#*******************************************************************
#DeletEntry
#*******************************************************************


sub deleteEntryPrompt{

print("Delete Entry.....\n");
print ("Please select a search criteria below to query entry you wish to delete...\n");
print("first name                1\n");
print("last name                 2\n");
print("Home phone                3\n");
print("Mobile phone              4\n");
print("Address                   5\n");
print("Zipcode                   6\n");
print("DOB                       7\n");
print("Salary                    8\n");

my $select = <STDIN>;

print"Please type filter content below\n";
my $filter =<STDIN>;

deleteFile();
deleteEntry($filter,$select);
update();
}


#*****************************************************************
#Query Database by certain criterion
#****************************************************************
sub query{

print ("Please select a search criteria below\n");
print("first name                1\n");
print("last name                 2\n");
print("Home phone                3\n");
print("Mobile phone              4\n");
print("Address                   5\n");
print("Zipcode                   6\n");
print("DOB                       7\n");
print("Salary                    8\n");

my $select = <STDIN>;

print"Please type filter content below\n";
my $filter =<STDIN>;

my @found = search($filter,$select);

 my $counter=0;
foreach(@found){

	format FILTER = 
First Name: @<<<<<<<<<<<<<<<<<<<<<<<        Last Name: @>>>>>>>>>>>>>>>>>>
      $_->firstName,                                   $_->lastName
Home Phone: @<<<<<<<<<<<<<<<<<<<<<<<	    Mobile Phone: @>>>>>>>>>>>>>>>
      $_->phone,					  $_->mobile
Address:    @<<<<<<<<<<<<<<<<<<<<<<<	    Zip code:  @>>>>>>>>>>>>>>>>>>
      $_->address,			    	       $_->zipcode
DOB:	    @<<<<<<<<<<<<<<<<<<<<<<<	    Salary:    @###############.##
      $_->dob,					       $_->salary
        
.
write;
$counter++;
}
	print ("Found " . $counter . " record(s)\n\n");
}

#******************************************************************
#search addressbook
#Prompts user asking on what criteria should the engine search by
#then returns all exact matches in seperat array allowing them to then 
#traverse through that array and modify its contents
#takes two parameter the value and the index of the choice to search 
#by. {firstname,lastname,phone,mobile,address,zipcode
#******************************************************************
sub search{
 
my $match = $_[0];
chop $match;
my $select = $_[1];

my @matches;
#print( $match );
#print( $select );
my $value = new Entry();
foreach $value (@entries){

	if ( $select == 1){
	 	if( $value->firstName eq $match){
			push(@matches, $value);
		
		}
	}elsif( $select == 2){
		if($value->lastName eq $match) {
			push(@matches,$value);
		}
	}elsif( $select == 3 ) {
		if($value->phone eq $match ) {
			push(@matches,$value);
		}
	}elsif( $select == 4 ){
		if($value->mobile eq $match ){
			push(@matches,$value);
		}
	}elsif($select == 5 ){
		if($value->address eq $match){
			push(@matches,$value);
		}
	}elsif( $select == 6 ){
		if($value->zipcode eq $match){
			push(@matches,$value);
		}
	}elsif( $select == 7 ){
		if($value->salary eq $match){
			push(@matches,$value);
		}
	}

}


return @matches;

}
#*******************************************************************
#Prompt Method
#Get valid input from user interactively
#*******************************************************************
sub prompt{
printf "Please enter valid data\n";
my $input = <STDIN>;
return \$input;
}

#*******************************************************************
#ERROR Message Print error message to screen
#*******************************************************************
sub errorMessage{
printf("Invalid Entry! Please try again.\n");
}
#*******************************************************************
#Main Method
#Bootstrap of program 
#
#*******************************************************************
package main;

#load file addressbook.txt
structure::load("abc.csv");
for(;;){


print ("\n	 AddressBook Perl edition\n\n");
print("Please choice one of the following Options: \n");
print("Add a new entry            1\n");
print("Delete an existing entry   2\n");
print("Select a new file          3\n");
print("Sorting                    4\n");
print("Search                     5\n");
print("Exit                       6\n");

my $input = <STDIN>;
chop ($input);

if($input){
	
	if ( $input == 1 ){
	  structure::AddEntry();
	}
	if( $input == 2 ) {
	   structure::deleteEntryPrompt();
	}
	if ( $input == 4 ) {
	   structure::sort();
	}
	if( $input == 5 ) {
	   structure::query();
	}
	if( $input == 3 ) {
	   structure::sel();
	}
	if ( $input == 6 ) {
	structure::update();
		last;}
	
	}
}