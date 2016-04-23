# Implements a basic PhantomJS domain scraper using Docker and make

# Because some websites might be unable to load, execute with `-i` flag to
# ignore errors

IMAGEDIR := images/
DOMAINDIR := domains/
$(shell mkdir -p $(DOMAINDIR))

DOMAINLIST := $(shell find $(DOMAINDIR) -type f)
IMAGELIST := $(DOMAINLIST:=.png)
IMAGELIST := $(IMAGELIST:$(DOMAINDIR)%=$(IMAGEDIR)%)

# Docker volume requires an absolute path
VOLUME := $(shell pwd)/


all: $(IMAGELIST)

%.png:
	mkdir -p $(IMAGEDIR)
	$(eval DOMAIN := $(patsubst $(IMAGEDIR)%.png,%,$@))
	sudo docker run -t --rm -v $(VOLUME):/raster-output herzog31/rasterize http://$(DOMAIN) "$@" 1200px*800px 1.0

# This rule will create 10,000 files in the $(DOMAINDIR) directory
mkdomains:
	cut -d, -f2 top-1m.csv | head -10000 | xargs -n1 -I{} touch "$(DOMAINDIR){}"
