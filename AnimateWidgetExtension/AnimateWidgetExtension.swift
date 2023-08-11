//
//  AnimateWidgetExtension.swift
//  AnimateWidgetExtension
//
//  Created by Danylo Bulanov on 11/27/22.
//

import WidgetKit
import SwiftUI
import Intents
import ClockRotationEffect

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct AnimateWidgetExtensionEntryView : View {
    var entry: Provider.Entry
    //let size: CGSize = CGSize(width: 75, height: 75)
    
    var body: some View {
         
        //倒计时
        //countdownType1()
        
        //上下移动
        //topScrollType1()
        
        
        //左右移动
        leftScrollType1()
        
        //案例1:4个圆圈图片旋转
        //widgetPhotoWallType1()
        
    }
    
    
}


@main
struct AnimateWidgetExtension: Widget {
    let kind: String = "AnimateWidgetExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            AnimateWidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct AnimateWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        AnimateWidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}

struct countdownType1: View {
    
    var body: some View {
        VStack(spacing:10) {
            Text(Calendar.current.startOfDay(for: Date()), style: .timer)
                .multilineTextAlignment(.center)
        }
    }
    
}

struct topScrollType1: View {
    
    let size: CGSize = CGSize(width: 75, height: 75)
    
    var body: some View {
        VStack(spacing:10) {
            
            Rectangle()
                .fill(Color.blue)
                .frame(
                    width: size.width*6,
                    height: size.height
                )
                .offset(x: 0, y: 0)
                .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(10), timezone: TimeZone.current, anchor: .zero))
        }
        .frame(width: 1,height: 1)
        .background(Color.yellow)
        .offset(x: -(size.height / 3), y: 0)
        .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(-10), timezone: TimeZone.current, anchor: .leading))
    }
}

struct leftScrollType1: View {
    
    let size: CGSize = CGSize(width: 75, height: 75)
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .center){
                //Text("AAAAAAAAAAAAAAAAAA")
                    //.offset(x: 0, y: 0)
                    //.modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(5), timezone: TimeZone.current, anchor: .center))
            }
            .frame(width: 250,height: 50)
            .background(Color.blue)
            //.opacity(0.5)
            .offset(x: 0, y: 0)
            .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(-5), timezone: TimeZone.current, anchor: .center))
        }
        .frame(width: 155,height: 2)
        .background(Color.yellow)
        .offset(x:0, y: 10)
        .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(5), timezone: TimeZone.current, anchor: .center))
    }
    
}

struct widgetPhotoWallType1: View {
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .topLeading) {
                Color.clear
                 .frame(width: geo.size.width,height: geo.size.height)
                
                //Text("[\(geo.size.width),\(geo.size.height)]")
                
                ZStack(alignment: .center) {
                    Image("1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                        .clipped()
                        .offset(x: 10, y: 10)
                        .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(10), timezone: TimeZone.current, anchor: .zero))
                }
                .frame(width: geo.size.width/2.0,height: geo.size.height/2.0)
                //.background(Color.green)
                
                ZStack(alignment: .center) {
                    Image("2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                        .clipped()
                        .offset(x: 10, y: 10)
                        .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(10), timezone: TimeZone.current, anchor: .zero))
                }
                .frame(width: geo.size.width/2.0,height: geo.size.height/2.0)
                //.background(Color.gray)
                .offset(x:geo.size.width/2.0, y: 0)
                
                ZStack(alignment: .center) {
                    Image("3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                        .clipped()
                        .offset(x: 10, y: 10)
                        .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(10), timezone: TimeZone.current, anchor: .zero))
                }
                .frame(width: geo.size.width/2.0,height: geo.size.height/2.0)
                //.background(Color.gray)
                .offset(x:0, y: geo.size.width/2.0)
                
                ZStack(alignment: .center) {
                    Image("3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                        .clipped()
                        .offset(x: 10, y: 10)
                        .modifier(ClockRotationModifier(period: ClockRotationPeriod.custom(10), timezone: TimeZone.current, anchor: .zero))
                }
                .frame(width: geo.size.width/2.0,height: geo.size.height/2.0)
                //.background(Color.gray)
                .offset(x:geo.size.width/2.0, y: geo.size.width/2.0)
                
                Image("photo_frame")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                                
            }
            .background(Color.black)
        }
    }
    
}
