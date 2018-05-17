#!/usr/bin/perl -w

@files = <container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cmac/*>;
foreach $file (@files) {
  my $first_line;
  open(M,"<",$file);
	my $count = 0;
	while( my $line = <M>)  {   
    		$first_line = $line;    
    		last if ++$count == 1;
	}
	@m = <M>;
  close(M);
  open(M,">",$file);		
	print M "`define DESIGNWARE_NOEXIST 1\n";
	print M @m;	
  close(M);
}

@files = <container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/cacc/*>;
foreach $file (@files) {
  my $first_line;
  open(M,"<",$file);
	my $count = 0;
	while( my $line = <M>)  {   
    		$first_line = $line;    
    		last if ++$count == 1;
	}
	@m = <M>;
  close(M);
  open(M,">",$file);		
	print M "`define DESIGNWARE_NOEXIST 1\n";
	print M @m;	
  close(M);
}

@files = <container_NVDLA_RTL/NVDLA/outdir/nv_full/vmod/nvdla/top/*>;
foreach $file (@files) {
  my $first_line;
  open(M,"<",$file);
	my $count = 0;
	while( my $line = <M>)  {   
    		$first_line = $line;    
    		last if ++$count == 1;
	}
	@m = <M>;
  close(M);
  open(M,">",$file);		
	print M "`define DESIGNWARE_NOEXIST 1\n";
	print M @m;	
  close(M);
}

