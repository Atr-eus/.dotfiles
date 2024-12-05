import re
import zipfile
import requests
from bs4 import BeautifulSoup

id = input("Enter doujin ID: ")
url = f"https://nhentai.net/g/{id}/"
res = requests.get(url)

if res.status_code == 200:
    print("loaded successfully")
else:
    print(f"ERROR LOADING SITE: {res.status_code}")

soup = BeautifulSoup(res.content, "html.parser")

pattern = re.compile(r"https://t(\d+)\.nhentai\.net/galleries/\d+/(\d+)t\.jpg")

doujin = []
for img in soup.find_all("img"):
    sauce = img.get("src")

    if sauce and pattern.match(sauce):
        sauce = re.sub(r"t(\d+)", "i", sauce)
        sauce = re.sub(r"(\d+)t\.jpg", r"\1.jpg", sauce)
        doujin.append(sauce)

for r in doujin:
    print(r)
print("PAGE COUNT:", len(doujin))

with zipfile.ZipFile(f"{id}.zip", "w", zipfile.ZIP_DEFLATED) as zf:
    for i, img_url in enumerate(doujin):
        img_res = requests.get(img_url)

        if img_res.status_code == 200:
            img_name = img_url.split("/")[-1]
            zf.writestr(img_name, img_res.content)
            print(f"done with {img_name}")
        else:
            print(f"something went wrong with {img_url}")

print("all done")
