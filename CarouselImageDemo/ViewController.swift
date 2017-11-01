//
//  ViewController.swift
//  CarouselImageDemo
//
//  Created by 高鑫 on 2017/11/1.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    let imgs : [String] = ["1", "2", "3", "4", "5"]

    var autoTimer: Timer?
    var scrollView = UIScrollView()
    var leftImg, midImg, rightImg : UIImageView?
    var pageControl = UIPageControl()
    let w = UIScreen.main.bounds.size.width
    var index  = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: w, height: w + 20))
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: w * 5, height: w)
        scrollView.backgroundColor = UIColor.groupTableViewBackground
        scrollView.contentOffset = CGPoint(x: w, y: 0)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        pageControl = UIPageControl(frame: CGRect(x: w/2 - 60, y: w, width: 120, height: 20))
        pageControl.numberOfPages = self.imgs.count
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
        
        leftImg = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: w))
        midImg = UIImageView(frame: CGRect(x: w, y: 0, width: w, height: w))
        rightImg = UIImageView(frame: CGRect(x: w * 2, y: 0, width: w, height: w))
        setImg()
        scrollView.addSubview(leftImg!)
        scrollView.addSubview(midImg!)
        scrollView.addSubview(rightImg!)
        
        autoScrollAction()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func autoScrollAction() {
        self.autoTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(scrollAction), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAction(){
        let offset = CGPoint(x: self.view.frame.width * 2, y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    func setImg() {
        if index == 0 {
            leftImg?.image = UIImage(named: imgs.last!)
            midImg?.image = UIImage(named: imgs.first!)
            rightImg?.image = UIImage(named: imgs[1])
        } else if index == imgs.count - 1 {
            leftImg?.image = UIImage(named: imgs[index - 1])
            midImg?.image = UIImage(named: imgs.last!)
            rightImg?.image = UIImage(named: imgs.first!)
        } else {
            leftImg?.image = UIImage(named: imgs[index - 1])
            midImg?.image = UIImage(named: imgs[index])
            rightImg?.image = UIImage(named: imgs[index + 1])
            
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        if imgs.count != 0{
            if(offset >= w * 2){
                scrollView.contentOffset = CGPoint(x: w, y: 0)
                index = index + 1
                if index == imgs.count {
                    index = 0
                }
            }
            if(offset <= 0){
                scrollView.contentOffset = CGPoint(x: w, y: 0)
                index = index - 1
                if index == -1 {
                    index = imgs.count - 1
                }
            }
            setImg()
            self.pageControl.currentPage = index
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        autoTimer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        autoScrollAction()
    }

}

