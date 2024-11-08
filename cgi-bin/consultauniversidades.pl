#!/usr/bin/perl -w
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp 'fatalsToBrowser';

my $file_path = './data/Programas_de_Universidades_8.csv';

my $cgi = CGI->new;

print $cgi->header(-type => 'text/plain', -charset => 'UTF-8');

if (! -e $file_path) {
    print "Error: El archivo de datos no se encuentra.";
    exit;
}

open(my $fh, '<:encoding(ISO-8859-1)', $file_path) or die "No se puede abrir el archivo: $!";
print "Archivo abierto correctamente.";
close $fh;
