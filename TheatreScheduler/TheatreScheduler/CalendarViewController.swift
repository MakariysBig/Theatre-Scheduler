import UIKit

final class CalendarViewController: UIViewController {
    
    private var selecteionDates = [Date]()
    private let funnyImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "dima")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private var date: [DateComponents] = [
        DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 9, day: 26),
        DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 10, day: 27),
    ]
    
    private let calendarView: UICalendarView = {
        let view = UICalendarView()
        let calendar = Calendar(identifier: .gregorian)
        let futureDate = calendar.date(byAdding: DateComponents(month: 6), to: Date()) ?? Date()
        view.calendar = calendar
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.availableDateRange = DateInterval(start: Date(), end: futureDate)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        setupCalendar()
    }
    
}
   
private extension CalendarViewController {
    
    func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        view.addSubview(funnyImage)
        funnyImage.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            calendarView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: 120)
        ])
        
        funnyImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupCalendar() {
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        dateSelection.selectedDates = date
        calendarView.selectionBehavior = dateSelection
    }
    
    func getDate(with component: DateComponents) -> Date {
        let calendar = Calendar.current
        let date = calendar.date(from: component)
        
        return date ?? Date()
    }
    
}

// MARK: - UICalendarSelectionMultiDateDelegate

extension CalendarViewController: UICalendarSelectionMultiDateDelegate {
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        let date = getDate(with: dateComponents)
        print("new date \(date)")
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        let date = getDate(with: dateComponents)
        print("remove \(date)")
    }
 
}


