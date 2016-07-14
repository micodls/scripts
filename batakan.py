import requests
import urllib
import webbrowser
import os
import csv
import re
import time
import string

form_key = '1FAIpQLSepk7nR-_4ED9a4nrJ-g2tHyOs_4C_f9rMv7IszDwajQhjivA' # change
google_form_link = 'https://docs.google.com/a/voyagerinnovation.com/forms/d/e/{}/formResponse'.format(form_key)

batakan = os.path.join(os.path.expanduser('~'), 'Desktop', 'batakan.html')
batakan_csv = os.path.join(os.path.expanduser('~'), 'Desktop', 'batakan.csv')

with open(batakan_csv, 'rb') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',')
    for row in spamreader:
        if row[0] == 'Name':
            continue
        else:
            fullname = string.capwords(row[0])
            firstname = (fullname.split()[0]).capitalize()
            lastname = (fullname.split()[-1]).capitalize()

        current_employer = re.sub('^.*at ', '', row[1])
        linkedin = re.sub('&$', '', row[2])  # row[3] = re.sub('&authType.*', '', row[3]

        # change entry ids
        payload = urllib.urlencode({
            'entry.478568801': fullname,
            'entry.136946294': linkedin,
            'entry.1031978321': current_employer,
        })

        # change username
        r = requests.get(google_form_link, payload, auth=('mico.delossantos@voyagerinnovation.com', ''))

        if r.status_code == 200:
            print 'Submitted {}'.format(row[0])
            # with open(batakan, 'w') as f:
            #     f.write(r.text)

            # webbrowser.open_new_tab('file://' + os.path.realpath(batakan)) # incase google sheets redirects
        else:
            print 'Failed submitting entry: {}'.format(row[0])

        time.sleep(1.5)


# Practice - csv to form
# https://docs.google.com/forms/d/e/1FAIpQLSepk7nR-_4ED9a4nrJ-g2tHyOs_4C_f9rMv7IszDwajQhjivA/viewform?entry.478568801=sdfsf&entry.136946294=gfhg&entry.1031978321=dfgdg


# LinkedIn Search
# business development specialist OR business developer OR Client Service Specialist OR Sales and Account Specialist - Philippines - 1st & 2nd connection
# https://www.linkedin.com/vsearch/p?type=people&keywords=business%20development%20specialist%20OR%20business%20developer%20OR%20Client%20Service%20Specialist%20OR%20Sales%20and%20Account%20Specialist&orig=FCTD&rsid=1729820781468472599273&pageKey=voltron_people_search_internal_jsp&trkInfo=tarId%3A1468472579745&search=Search&openFacets=N,G,CC&f_G=ph%3A0&f_N=S,F

# Javascript scraper script
# Requirement: allow-control-allow-origin (web store)
# $("#results li.mod.result.people").each(function(index, value) {
# name = $(value).find(".title.main-headline").html();
# link = $(value).find(".title.main-headline").attr("href");
# current = $(value).find(".snippet .title").first().text();
# $.get("https://docs.google.com/a/voyagerinnovation.com/forms/d/e/1FAIpQLScq0muwmbPWo8R4lK8wWK8k5a4hNdFhKDn4e00YOZF1OGzs4Q/formResponse", {"entry.20403266": "Mico", "entry.1771964549": name,
# "entry.639541837": link, "entry.1109255632": current});
# });
