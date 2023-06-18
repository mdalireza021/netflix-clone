//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by BS1096 on 7/6/23.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0;
    case TrendingTv = 1;
    case Popular = 2;
    case Upcoming = 3;
    case TopRated = 4;
}

class HomeViewController: UIViewController {
    let sectionTitles: [String] = ["Tranding Movies", "Tranding Tv", "Popular", "Upcoming Movies", "Top rated"];
    
    private var headerView: HeroHeaderUIView?
    private var randomTrendingMovie: Title?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier);
        return table;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .systemBackground;
        view.addSubview(homeFeedTable);
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView;
        
        configureHeroHeaderView()
       
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo");
        image = image?.withRenderingMode(.alwaysOriginal);
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrandingMovies { [weak self] result in
                switch result {
                case .success(let titles):
                    let selectedTitle = titles.randomElement()
                    self?.randomTrendingMovie = selectedTitle
                   self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
                    
                case .failure(let erorr):
                    print(erorr.localizedDescription)
                }
            }
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        homeFeedTable.frame = view.bounds;
    }
    
    private func getTrandingMovies() {
        APICaller().getTrandingMovies { results in
            switch results {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getTrandingTvs() {
        APICaller.shared.getTrandingTvs { results in
            switch results {
            case .success(let tvs):
                print(tvs)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getPopular() {
        APICaller.shared.getPopular {
            results in switch results {
            case .success(let popular):
                print(popular)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getUpcomingMovies() {
        APICaller.shared.getPopular {
            results in switch results {
            case .success(let upcomingMovies):
                print(upcomingMovies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getTopRatedMovies() {
        APICaller.shared.getTopRatedMovies {
            results in switch results {
            case .success(let topRatedMovies):
                print(topRatedMovies)
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell();
        }
        
        cell.delegate = self;
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrandingMovies {
                result in switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrandingTvs {
                result in switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular {
                result in switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies {
                result in switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies {
                result in switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold);
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height);
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter();
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section];
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset;
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
