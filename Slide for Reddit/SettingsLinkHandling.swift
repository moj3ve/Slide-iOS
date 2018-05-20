//
//  SettingsLinkHandling.swift
//  Slide for Reddit
//
//  Created by Carlos Crane on 7/17/17.
//  Copyright © 2017 Haptic Apps. All rights reserved.
//

import UIKit
import reddift

class SettingsLinkHandling: UITableViewController, UISearchBarDelegate {

    var domainEnter = UISearchBar()

    var useSafariVCCell: UITableViewCell = UITableViewCell()
    var useSafariVC = UISwitch()

    var internalGifCell: UITableViewCell = UITableViewCell()
    var internalGif = UISwitch()

    var internalImageCell: UITableViewCell = UITableViewCell()
    var internalImage = UISwitch()

    var internalAlbumCell: UITableViewCell = UITableViewCell()
    var internalAlbum = UISwitch()

    var internalYouTubeCell: UITableViewCell = UITableViewCell()
    var internalYouTube = UISwitch()

    //for future var dontLoadImagePreviewsCell: UITableViewCell = UITableViewCell()
    // var dontLoadImagePreviews = UISwitch()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = ColorUtil.getColorForSub(sub: "")
        navigationController?.navigationBar.tintColor = UIColor.white
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch (indexPath.section) {
            case 1:
                PostFilter.openExternally.remove(at: indexPath.row)
                break
            default: fatalError("Unknown section")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            PostFilter.saveAndUpdate()
        }
    }

    func switchIsChanged(_ changed: UISwitch) {
        if (changed == internalImage) {
            SettingValues.internalImageView = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_internalImageView)
        } else if (changed == internalGif) {
            SettingValues.internalGifView = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_internalGifView)
        } else if (changed == internalAlbum) {
            SettingValues.internalAlbumView = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_internalAlbumView)
        } else if (changed == internalYouTube) {
            SettingValues.internalYouTube = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_internalYouTube)
        } else if (changed == useSafariVC) {
            SettingValues.safariVC = changed.isOn
            UserDefaults.standard.set(changed.isOn, forKey: SettingValues.pref_safariVC)
        }
        UserDefaults.standard.synchronize()
        tableView.reloadData()
    }

    override func loadView() {
        super.loadView()

        self.view.backgroundColor = ColorUtil.backgroundColor
        // set the title
        self.title = "Link Handling"

        internalGif = UISwitch()
        internalGif.isOn = SettingValues.internalGifView
        internalGif.addTarget(self, action: #selector(SettingsLinkHandling.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
        internalGifCell.textLabel?.text = "Load gifs in app"
        internalGifCell.accessoryView = internalGif
        internalGifCell.backgroundColor = ColorUtil.foregroundColor
        internalGifCell.textLabel?.textColor = ColorUtil.fontColor
        internalGifCell.selectionStyle = UITableViewCellSelectionStyle.none

        internalAlbum = UISwitch()
        internalAlbum.isOn = SettingValues.internalAlbumView
        internalAlbum.addTarget(self, action: #selector(SettingsLinkHandling.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
        internalAlbumCell.textLabel?.text = "Load albums in app"
        internalAlbumCell.accessoryView = internalAlbum
        internalAlbumCell.backgroundColor = ColorUtil.foregroundColor
        internalAlbumCell.textLabel?.textColor = ColorUtil.fontColor
        internalAlbumCell.selectionStyle = UITableViewCellSelectionStyle.none

        internalImage = UISwitch()
        internalImage.isOn = SettingValues.internalImageView
        internalImage.addTarget(self, action: #selector(SettingsLinkHandling.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
        internalImageCell.textLabel?.text = "Load images in app"
        internalImageCell.accessoryView = internalImage
        internalImageCell.backgroundColor = ColorUtil.foregroundColor
        internalImageCell.textLabel?.textColor = ColorUtil.fontColor
        internalImageCell.selectionStyle = UITableViewCellSelectionStyle.none

        internalYouTube = UISwitch()
        internalYouTube.isOn = SettingValues.internalYouTube
        internalYouTube.addTarget(self, action: #selector(SettingsLinkHandling.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
        internalYouTubeCell.textLabel?.text = "Load YouTube videos in app"
        internalYouTubeCell.accessoryView = internalYouTube
        internalYouTubeCell.backgroundColor = ColorUtil.foregroundColor
        internalYouTubeCell.textLabel?.textColor = ColorUtil.fontColor
        internalYouTubeCell.selectionStyle = UITableViewCellSelectionStyle.none

        useSafariVC = UISwitch()
        useSafariVC.isOn = SettingValues.safariVC
        useSafariVC.addTarget(self, action: #selector(SettingsLinkHandling.switchIsChanged(_:)), for: UIControlEvents.valueChanged)
        useSafariVCCell.textLabel?.text = "Use Safari web view"
        useSafariVCCell.detailTextLabel?.text = "The Safari VC will still show ads if you have purchased pro"
        useSafariVCCell.accessoryView = useSafariVC
        useSafariVCCell.backgroundColor = ColorUtil.foregroundColor
        useSafariVCCell.textLabel?.textColor = ColorUtil.fontColor
        useSafariVCCell.selectionStyle = UITableViewCellSelectionStyle.none
        self.tableView.tableFooterView = UIView()


        domainEnter.searchBarStyle = UISearchBarStyle.minimal
        domainEnter.placeholder = "Enter domain to open externally"
        domainEnter.delegate = self
        domainEnter.returnKeyType = .done
        domainEnter.textColor = ColorUtil.fontColor
        domainEnter.setImage(UIImage(), for: .search, state: .normal)

    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }


    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        PostFilter.openExternally.append(domainEnter.text! as NSString)
        domainEnter.text = ""
        PostFilter.saveAndUpdate()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
            case 0: return self.useSafariVCCell
            case 1: return self.internalImageCell
            case 2: return self.internalGifCell
            case 3: return self.internalAlbumCell
            case 4: return self.internalYouTubeCell
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            let cell = UITableViewCell()
            cell.backgroundColor = ColorUtil.foregroundColor
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = ColorUtil.foregroundColor
            cell.textLabel?.textColor = ColorUtil.fontColor
            cell.textLabel?.text = PostFilter.openExternally[indexPath.row] as String
            return cell

        default: fatalError("Unknown section")
        }
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch (section) {
        case 1: return domainEnter
        default: return UIView()
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }


    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.textColor = ColorUtil.fontColor
        label.font = FontGenerator.boldFontOfSize(size: 20, submission: true)
        let toReturn = label.withPadding(padding: UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 0))
        toReturn.backgroundColor = ColorUtil.backgroundColor
        switch(section) {
        case 0: label.text = "Content Settings"
            break
        case 1: label.text =  "Open External Link Matching"
            break
        default: label.text  = ""
            break
        }
        return toReturn
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0: return 5   // section 0 has 2 rows
                case 1: return PostFilter.openExternally.count
        default: fatalError("Unknown number of sections")
        }
    }
}
