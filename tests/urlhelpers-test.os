#Использовать ".."

Перем юТест;

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
    
    юТест = ЮнитТестирование;
    
    СписокТестов = Новый Массив;
        
    СписокТестов.Добавить("ТестДолжен_ПроверитьФормированиеСтрокиЗапроса");
    СписокТестов.Добавить("ТестДолжен_ПроверитьФормированиеСтрокиЗапросаЕслиПараметрОдин");
    СписокТестов.Добавить("ТестДолжен_ПроверитьФормированиеСтрокиЗапросаЕслиСписокПараметровПуст");
    СписокТестов.Добавить("ТестДолжен_ПроверитьФормированиеСтрокиЗапросаКогдаКлючиЭлементыМассива");

    СписокТестов.Добавить("ТестДолжен_ПроверитьФормированиеСтруктурыПараметровЗапроса");    
    СписокТестов.Добавить("ТестДолжен_ПроверитьФормированиеСтруктурыПараметровЗапросаСЛишнимПараметром");
    
    Возврат СписокТестов;

КонецФункции

Процедура ТестДолжен_ПроверитьФормированиеСтрокиЗапроса() Экспорт

    
    Эталон1 = "param=value&%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80=%D0%B7%D0%BD%D0%B0%D1%87%D0%B5%D0%BD%D0%B8%D0%B5";

    Параметры1 = Новый Соответствие;
    Параметры1.Вставить("param", "value");
    Параметры1.Вставить("параметр", "значение");

    юТест.ПроверитьРавенство(Эталон1, РаботаСUrl.СформироватьСтрокуЗапроса(Параметры1));

КонецПроцедуры

Процедура ТестДолжен_ПроверитьФормированиеСтрокиЗапросаЕслиСписокПараметровПуст() Экспорт

    Эталон1 = "";

    Параметры1 = Новый Соответствие;

    юТест.ПроверитьРавенство(Эталон1, РаботаСUrl.СформироватьСтрокуЗапроса(Параметры1));

КонецПроцедуры

Процедура ТестДолжен_ПроверитьФормированиеСтрокиЗапросаЕслиПараметрОдин() Экспорт
    
    Эталон1 = "param=value";

    Параметры1 = Новый Соответствие;
    Параметры1.Вставить("param", "value");

    юТест.ПроверитьРавенство(Эталон1, РаботаСUrl.СформироватьСтрокуЗапроса(Параметры1));

КонецПроцедуры

Процедура ТестДолжен_ПроверитьФормированиеСтрокиЗапросаКогдаКлючиЭлементыМассива() Экспорт
    
    Эталон1 = "F%5B0%5D=val1&F%5B1%5D=val2&F%5B2%5D=val3&F%5B3%5D=val4";

    Параметры1 = Новый Соответствие;
    Параметры1.Вставить("F[0]", "val1");
    Параметры1.Вставить("F[1]", "val2");
    Параметры1.Вставить("F[2]", "val3");
    Параметры1.Вставить("F[3]", "val4");

    юТест.ПроверитьРавенство(Эталон1, РаботаСUrl.СформироватьСтрокуЗапроса(Параметры1));

КонецПроцедуры

Процедура ТестДолжен_ПроверитьФормированиеСтруктурыПараметровЗапроса() Экспорт

    Эталон = Новый Структура("param1,param2,param3", "required", "value1", "value2");
    
    ОбязательныеПараметры = Новый Структура("param1", "required");
    ДополнительныеПараметры = Новый Структура("param2,param3", "value1", "value2");

    ПараметрыЗапроса = РаботаСUrl.СформироватьСтруктуруПараметровЗапроса(
        "param1,param2,param3,param4",
        ОбязательныеПараметры,
        ДополнительныеПараметры
    );    

    юТест.ПроверитьИстину(СтруктурыИдентичны(Эталон, ПараметрыЗапроса), "Ожидали, что Эталон и ПараметрыЗапроса будут идентичны, а на самом деле - нет");

КонецПроцедуры

Процедура ТестДолжен_ПроверитьФормированиеСтруктурыПараметровЗапросаСЛишнимПараметром() Экспорт
    
    Параметры = Новый Структура("param1,param2,param3", "value1", "value2", "value3");

    МассивАргументов = Новый Массив;
    МассивАргументов.Добавить("param1,param2");
    МассивАргументов.Добавить(Параметры);
    МассивАргументов.Добавить(Неопределено);

    ПроверитьЧтоВызовВыбрасываетИсключение(РаботаСUrl, "СформироватьСтруктуруПараметровЗапроса", МассивАргументов, "В запрос передан недопустимый параметр param3");

КонецПроцедуры

Процедура ПроверитьЧтоВызовВыбрасываетИсключение(Объект, ИмяМетода, МассивАргументовМетода, ФрагментИсключения="")

    ИсключениеВозникло = Ложь;

    Попытка
        Рефлектор = Новый Рефлектор;
        Рефлектор.ВызватьМетод(Объект, ИмяМетода, МассивАргументовМетода);
    Исключение
        ИсключениеВозникло = Истина;
        ТекстИсключения = ОписаниеОшибки();
    КонецПопытки;
    
    юТест.ПроверитьИстину(
        ИсключениеВозникло И Найти(ТекстИсключения, ФрагментИсключения) > 0, 
        "Ожидали, что " + ИмяМетода + " ВЫБРОСИТ ИСКЛЮЧЕНИЕ" + 
            ?(ЗначениеЗаполнено(ФрагментИсключения), " СОДЕРЖАЩЕЕ ТЕКСТ <" + ФрагментИсключения + ">, а был текст <" + ТекстИсключения + ">.", "")
    );
        
КонецПроцедуры

Функция СтруктурыИдентичны(Структура1, Структура2) 
    Если Структура1.Количество() = Структура2.Количество() Тогда
        Для каждого ЭлементСтруктуры из Структура1 Цикл
            Если НЕ Структура2.Свойство(ЭлементСтруктуры.Ключ) Тогда
                Возврат Ложь;
            КонецЕсли;
            Если Структура1[ЭлементСтруктуры.Ключ] <> Структура2[ЭлементСтруктуры.Ключ] Тогда
                Возврат Ложь;
            КонецЕсли
        КонецЦикла;
    КонецЕсли;
    Возврат Истина;
КонецФункции