#!/usr/bin/env perl

use strict;
use Archive::Probe;

die "jar file is required\n" unless scalar(@ARGV) > 0;
my $base = $ARGV[0];
my $tmpdir = '/tmp';
my $probe = Archive::Probe->new();
$probe->working_dir($tmpdir);
$probe->add_pattern(
    '\.class$',
    sub {
        my ($pattern, $file_ref) = @_;

        # do something with result files
        my $map = {};
        foreach my $fp (@$file_ref) {
            my $idx = rindex($fp, '__/');
            my $class = $fp;
            my $jar_path = "";
            if ($idx != -1) {
                $class = substr($fp, $idx + 3);
                $jar_path = substr($fp, 0, $idx + 2);
            }
            $class =~ s/\//./g;
            $class =~ s/\.class$//g;
            $jar_path =~ s/__//g;
            $jar_path =~ s/$tmpdir//g;
            if (!$map->{$class}) {
                $map->{$class} = [$jar_path];
            }
            else {
                push @{$map->{$class}}, $jar_path;
            }
        }

        my $j = 1;
        foreach my $clazz (sort(keys((%$map)))) {
            if (scalar(@{$map->{$clazz}}) > 1) {
                printf "%05d %s:\n", $j++, $clazz;
                my $i = 1;
                foreach my $jar (@{$map->{$clazz}}) {
                    printf "    %02d %s\n", $i++, $jar;
                }
            }
        }
});
$probe->search($base, 0);
