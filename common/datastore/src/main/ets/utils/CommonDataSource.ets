// 这个类是一个通用的数据源类，用于存储数据并通知数据变化
export class CommonDataSource<T> implements IDataSource {
	// 数据数组
	private dataArray: T[] = [];
	// 监听器
	private listeners: DataChangeListener[] = [];

	// 构造函数
	constructor(element: T[]) {
		this.dataArray = element;
	}

	// 获取数据
	public getData(index: number) {
		console.log('getData', index, this.dataArray[index]);
		return this.dataArray[index]
	}

	// 总数
	public totalCount(): number {
		return this.dataArray.length;
	}

	// 增加数据
	public addData(index: number, data: T[]): void {
		this.dataArray = this.dataArray.concat(data);
		this.notifyDataAdd(index);
	}

	// 删除数据
	public pushData(data: T): void {
		this.dataArray.push(data);
		this.notifyDataAdd(this.dataArray.length - 1);
	}

	// 从监听器列表中移除指定的监听器
	unregisterDataChangeListener(listener: DataChangeListener): void {
		const pos = this.listeners.indexOf(listener);
		if (pos >= 0) {
			this.listeners.splice(pos, 1);
		}
	}

	// 注册监听器
	registerDataChangeListener(listener: DataChangeListener): void {
		if (this.listeners.indexOf(listener) < 0) {
			this.listeners.push(listener);
		}
	}

	// 重新加载数据
	notifyDataReload(): void {
		this.listeners.forEach((listener: DataChangeListener) => {
			listener.onDataReloaded();
		})
	}

	notifyDataAdd(index: number): void {
		this.listeners.forEach((listener: DataChangeListener) => {
			listener.onDataAdd(index);
		})
	}

	notifyDataChange(index: number): void {
		this.listeners.forEach((listener: DataChangeListener) => {
			listener.onDataChange(index);
		})
	}

	notifyDataDelete(index: number): void {
		this.listeners.forEach((listener: DataChangeListener) => {
			listener.onDataDelete(index);
		})
	}

	notifyDataMove(from: number, to: number): void {
		this.listeners.forEach((listener: DataChangeListener) => {
			listener.onDataMove(from, to);
		})
	}
}