//
//  ElapsedTime.swift
//  Worderoo
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct ElapsedTime: View {
    let startTime: Date
    let endTime: Date? //if game is over
    
    var body: some View {
        if let endTime {
            Text(endTime, format: timeFormat)
        } else {
            Text(TimeDataSource<Date>.currentDate, format: timeFormat)
        }
    }
    
    var timeFormat: SystemFormatStyle.DateOffset {
        .offset(
            to: startTime,
            allowedFields: [.minute, .second]
        )
    }
}

