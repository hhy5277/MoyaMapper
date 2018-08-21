//
//  Modelable.swift
//  MoyaMapper
//
//  Created by LinXunFeng on 2018/5/18.
//  Copyright © 2018年 LinXunFeng. All rights reserved.
//

import SwiftyJSON

public struct NullParameter: ModelableParameterType {
    /// 请求成功时状态码对应的值 (默认值 "")
    public static var successValue: String {return ""}
    /// 状态码对应的键 (默认值 "")
    public static var statusCodeKey: String {return ""}
    /// 请求后的提示语对应的键 (默认值 "")
    public static var tipStrKey: String {return ""}
    /// 请求后的主要模型数据的键 (默认值 "")
    public static var modelKey: String {return ""}
}

public protocol ModelableParameterType {
    /// 请求成功时状态码对应的值
    static var successValue: String { get }
    /// 状态码对应的键
    static var statusCodeKey: String { get }
    /// 请求后的提示语对应的键
    static var tipStrKey: String { get }
    /// 请求后的主要模型数据的键
    static var modelKey: String { get }
}

// MARK:- Model
public protocol Modelable {
    init(_ json: JSON)
}

extension JSON {
    /// 模型解析
    ///
    /// - Parameter type: 模型类型
    /// - Returns: 模型
    public func modelValue<T: Modelable>(_ type: T.Type) -> T {
        return T.init(self)
    }
    
    /// 模型数组解析
    ///
    /// - Parameter type: 模型类型
    /// - Returns: 模型数组
    public func modelsValue<T: Modelable>(_ type: T.Type) -> [T] {
        return arrayValue.compactMap { $0.modelValue(type) }
    }
}

