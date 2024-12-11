import re
import zipfile
import requests
from bs4 import BeautifulSoup

# process input and fetch page
id = input("Enter doujin ID: ")
url = f"https://nhentai.net/g/{id}/"
res = requests.get(url)

if res.status_code == 200:
    print("Loaded successfully.")
else:
    print(f"ERROR LOADING SITE: {res.status_code}")

soup = BeautifulSoup(res.content, "html.parser")

# get title
doujin_left = soup.find("span", class_="before")
doujin_middle = soup.find("span", class_="pretty")
doujin_right = soup.find("span", class_="after")
if doujin_left and doujin_middle and doujin_right:
    doujin_title = (
        doujin_left.get_text(strip=True)
        + " "
        + doujin_middle.get_text(strip=True)
        + " "
        + doujin_right.get_text(strip=True)
    )
else:
    doujin_title = id

# get image links
pattern = re.compile(r"https://t(\d+)\.nhentai\.net/galleries/\d+/(\d+)t\.jpg")
doujin = []

for img in soup.find_all("img"):
    sauce = img.get("src")

    if sauce and pattern.match(sauce):
        sauce = re.sub(r"t(\d+)", "i", sauce)
        sauce = re.sub(r"(\d+)t\.jpg", r"\1.jpg", sauce)
        doujin.append(sauce)

print(f"Page count: {len(doujin)}.")
print(f"Saving into: {doujin_title}.zip.")

# download
with zipfile.ZipFile(f"{doujin_title}.zip", "w", zipfile.ZIP_DEFLATED) as zf:
    for i, img_url in enumerate(doujin):
        img_res = requests.get(img_url)

        if img_res.status_code == 200:
            img_name = img_url.split("/")[-1]
            zf.writestr(img_name, img_res.content)
            print(f"Done with {img_name}...")
        else:
            print(f"Something went wrong with {img_url}...")

print("all done")
