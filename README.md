# Search for hardcoded IP addresses
A PowerShell script that searches for IP addresses in multiple file types.

This is a script I put together because I had to search a large directory of files for hardcoded IP addresses. I pieced the code together thanks to a couple links:

- https://social.technet.microsoft.com/Forums/en-US/40be42d2-9776-4ef4-8fe0-8377f6b06d66/script-to-search-for-ip-addresses-within-files-and-registry?forum=winserverpowershell (This is where I got a majority of the code.)
 
- http://www.powershelladmin.com/wiki/PowerShell_regex_to_accurately_match_IPv4_address_(0-255_only) (I got the more refined regex from this link. Though it only reduced how many IPs I found by about 15-20%.)

The project I used this script on found over 9000 "IP addresses." The final list included a lot of version numbers. It even managed to pull numbers from the middle of a long ID. I was able to reduce the number down to about 7000 ip addresses by using this regex:

(?:(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d)\.){3}(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d) 

The script exports the results to a csv that I then used to sort and trim the results. The whole process took 20-30 minutes to get the actual IPs down to around 350. The results will include the file path of where the IP was found for verification purposes. Just looking at the IPs should be enough to figure out IP vs. version or some other set of numbers for most. Use the below regex if you have an idea of what IPs you're looking for:

(172\.\d+\.\d+\.\d+)

Add or remove file extensions to $FilesOfInterst for searching.

Change the $input_path file path on line 15 to reflect the location of the files needing searched.

Change the Export-Csv path on line 43 to reflect where results should be placed.
