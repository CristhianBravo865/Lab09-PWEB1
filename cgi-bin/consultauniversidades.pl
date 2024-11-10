#!/usr/bin/perl -w
use strict;
use warnings;
use CGI qw(:standard);
use CGI::Carp 'fatalsToBrowser';

my $file_path = './data/Programas_de_Universidades_8.csv';
my $cgi = CGI->new;

my $nombre = $cgi->param('nombre') || '';
my $periodo = $cgi->param('periodo') || '';
my $departamento = $cgi->param('departamento') || '';
my $programa = $cgi->param('programa') || '';

print $cgi->header(-type => 'text/plain', -charset => 'UTF-8');

if (! -e $file_path) {
    print "Error: El archivo de datos no se encuentra.";
    exit;
}

open(my $fh, '<:encoding(ISO-8859-1)', $file_path) or die "No se puede abrir el archivo: $!";

my @resultados;
while (my $line = <$fh>) {
    chomp $line;
    my @campos = split(/\|/, $line);

    if (($nombre eq '' || $campos[1] =~ /\Q$nombre\E/i) &&
        ($periodo eq '' || $campos[6] =~ /\Q$periodo\E/i) &&
        ($departamento eq '' || $campos[12] =~ /\Q$departamento\E/i) &&
        ($programa eq '' || $campos[18] =~ /\Q$programa\E/i)) {

        push @resultados, join(", ", @campos[1, 6, 12, 18]);
    }
}
close $fh;

if (@resultados) {
    print join("\n", @resultados);
} else {
    print "No se encontraron resultados para los criterios especificados.";
}
