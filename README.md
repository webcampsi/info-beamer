# info-beamer
the info-beamer nodes (and related scripts/data) used at the webcamp event

# Running

extract info-beamer-pi-0.9.4-beta.ce8d97-jessie.tar.gz into /home/webcamp/info-beamer-pi

clone the info-beamer repository into /srv/info-beamer

add a crontab entry like this:
```
@reboot /path/to/run-beamer.sh
```

and another one:
```
* * * * * /path/to/clock.py
```

and one more: :smile:
```
*/2 * * * * /path/to/check-git.sh
```


# Licence

The info-beamer node scripts, python files are released under the MIT Licence, but please note that the fonts come with their own licences, OpenSans is released under the [Apache License](Apache License.txt) and Montserrat falls under the [SIL Open Font License](bar/SIL Open Font License.txt).
