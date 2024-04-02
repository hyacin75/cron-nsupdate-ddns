# cron-nsupdate-ddns

---

Simple shell script and Dockerfile to update an RFC 2136 record with your current internet address

---

Required parameters -

* SERVER
* ZONE
* HOST
* KEY


The first three are the standard fields from an nsupdate request.

The last is a bind key to provide access to update the zone.

Other authentication methods are not supported, and key is mandatory.  None of this should be difficult to udpate if you have other requirements though.

I contemplated utilizing a local key/val store to track whether the address has changed or not, but opted instead to simply query the record we're attempting to update.  This means the server you are trying to send the update to must also allow querying of this record for this to work and not hammer it with updates.

The key can be mounted from a Kubernetes secret as in the sample cron manifest, or you can mount it to your pod another way.

As a very basic means of error checking the script validates that the result of the api call and dns lookup are IP addresses - that being the case, the record must already exist or the script will fail.

---
