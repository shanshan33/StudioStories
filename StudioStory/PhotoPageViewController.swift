//
//  PhotoPageViewController.swift
//  StudioStory
//
//  Created by Shanshan Zhao on 20/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class PhotoPageViewController: UIPageViewController {

    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getContentViewController(withIdentifier: "Page1"),
            self.getContentViewController(withIdentifier: "Page2")
        ]
    }()
    
    func getContentViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate   = self
        
        if let firstPhoto = pages.first
        {
            setViewControllers([firstPhoto], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension PhotoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex > 0 else { return pages.last}
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
}

extension PhotoPageViewController: UIPageViewControllerDelegate { }





