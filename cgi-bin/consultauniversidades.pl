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

print $cgi->header(-type => 'text/html', -charset => 'UTF-8');

if (! -e $file_path) {
    print "<p>Error: El archivo de datos no se encuentra.</p>";
    exit;
}

open(my $fh, '<:encoding(ISO-8859-1)', $file_path) or die "No se puede abrir el archivo: $!";

my $resultados_html = "<table border='1'><tr><th>Nombre Universidad</th><th>Periodo Licenciamiento</th><th>Departamento</th><th>Programa</th></tr>";
my $hay_resultados = 0;

while (my $line = <$fh>) {
    chomp $line;
    my @fields = split(/\|/, $line);

    my $nombre_uni = $fields[1];
    my $periodo_lic = $fields[6];
    my $depto_local = $fields[12];
    my $denominacion_prog = $fields[18];

    if (($nombre eq '' || $nombre_uni =~ /\Q$nombre\E/i) &&
        ($periodo eq '' || $periodo_lic =~ /\Q$periodo\E/i) &&
        ($departamento eq '' || $depto_local =~ /\Q$departamento\E/i) &&
        ($programa eq '' || $denominacion_prog =~ /\Q$programa\E/i)) {
        $resultados_html .= "<tr><td>$nombre_uni</td><td>$periodo_lic</td><td>$depto_local</td><td>$denominacion_prog</td></tr>";
        $hay_resultados = 1;
    }
}
close $fh;

if ($hay_resultados) {
    $resultados_html .= "</table>";
    print $resultados_html;
} else {
    print "<p>No se encontraron resultados para los criterios especificados.</p>";
}
