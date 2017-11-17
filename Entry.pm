#class Entry
#Class module that will simulate a class object in perl
#author Michael Vasquez
#Cs 408
#Project 1 V Perl 
#Feb 20, 2006
#for additional help on perl objects see this website which got me started thanks!
##http://www.codeproject.com/perl/camel_poop.asp
#Perl Object Oriented Programming
#By Khurt Williams 
package Entry;
use strict;

#Nested Data Structure this Data Structure will contain two elements 
#one element is a reference and the other is hash 
#This complex data structure is created to emulate a class construct
#constructor
sub new {
    
    my $self = {
        _firstName => undef,
        _lastName  => undef,
        _phone     => undef,
        _mobile    => undef,
        _address   => undef,
        _zipcode   => undef,
        _dob       => undef,
        _salary    => undef
    };
    bless $self;
    return $self;
}

#accessor method for Person first name
sub firstName {
    my ( $self, $firstName ) = @_;
    $self->{_firstName} = $firstName if defined($firstName);
    return $self->{_firstName};
}

#accessor method for Person last name
sub lastName {
    my ( $self, $lastName ) = @_;
    $self->{_lastName} = $lastName if defined($lastName);
    return $self->{_lastName};
}

#accessor method for a phone #
sub phone {
    my ( $self, $phone ) = @_;
    $self->{_phone} = $phone if defined($phone);
    return $self->{_phone};
}

#accessor method for mobile number
sub mobile {
    my ( $self, $mobile ) = @_;
    $self->{_mobile} = $mobile if defined($mobile);
    return $self->{_mobile};
}

#accessor method for Person address
sub address {
    my ( $self, $address ) = @_;
    $self->{_address} = $address if defined($address);
    return $self->{_address};
}

#accessor method for Person zipcode
sub zipcode {
    my ( $self, $zipcode ) = @_;
    $self->{_zipcode} = $zipcode if defined($zipcode);
    return $self->{_zipcode};
}

#accessor method for dob
sub dob {
    my ( $self, $dob ) = @_;
    $self->{_dob} = $dob if defined($dob);
    return $self->{_dob};
}

#accessor method for salary
sub salary {
    my ( $self, $salary ) = @_;
    $self->{_salary} = $salary if defined($salary);
    return $self->{_salary};
}

#print method using STDOUT using colon as delimiter
sub write {

    #create local output stream and write entry to file
    my $output="abc.csv";
    open(DAT,">>$output") || die("Cannot Open File");
    my ($self) = @_;

    #print Person info
    print DAT ( $self->firstName );
    print DAT (" ");
    print DAT ($self->lastName) ;
    print DAT (":");
    print DAT ($self->phone);
    print DAT (":");
    print DAT ( $self->mobile);
    print DAT (":");
    print DAT ( $self->address);
    print DAT (" ");
    print DAT ($self->zipcode);
    print DAT (":");
    print DAT ( $self->dob);
    print DAT (":");
    print DAT ( $self->salary);
    print DAT ("\n");

 
    close $output

}

sub showElement{
#my($self,$value)=@_;
#my $elemPos = $_[0];
#chop $elemPos;
my($self)=@_;

format ELEMENT = 
First Name: @<<<<<<<<<<<<<<<<<<<<<<<        Last Name: @>>>>>>>>>>>>>>>>>>
     $self->firstName,                                   $self->lastName
Home Phone: @<<<<<<<<<<<<<<<<<<<<<<<	    Mobile Phone: @>>>>>>>>>>>>>>>
$self->phone,					  $self->mobile
Address:    @<<<<<<<<<<<<<<<<<<<<<<<	    Zip code:  @>>>>>>>>>>>>>>>>>>
      $self->address,			    	       $self->zipcode
DOB:	    @<<<<<<<<<<<<<<<<<<<<<<<	    Salary:    @###############.##
      $self->dob,					       $self->salary
      
.
CORE::write;
}

1;
